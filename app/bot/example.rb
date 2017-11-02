include Facebook::Messenger

Bot.on :message do |message|
  graph = Koala::Facebook::API.new(ENV['FB_ACCESS_TOKEN'])
  fbuser_obj = graph.get_object(message.sender.fetch("id"))

  #create user
  user =  User.find_or_initialize_by(fbid: fbuser_obj['id'])
  user.mfbid = message.sender.fetch("id")
  user.first_name = fbuser_obj.fetch('first_name')
  user.last_name = fbuser_obj.fetch('last_name')
  user.gender = fbuser_obj.fetch('gender')

  if user.save
    Rails.logger.info "ID: #{message.id}, Sender: #{user.fullname} saved!"
  else
    Rails.logger.warn "ID: #{message.id}, Sender: #{user.errors.full_messages.to_sentence} invalid!"
  end


  arr_string = message.text.downcase.split(';')
  able_to_teach = arr_string.count == 2 && arr_string[0]&.include?('keyword:') && arr_string[1]&.include?('reply:')
  if able_to_teach
    response = Response.new(keyword: arr_string[0].split(':')[1], reply: arr_string[1].split(':')[1])
    text = if response.save
             "Got it thanks. now try #{response.keyword} to see if its working. :D"
           else
             "Im sorry but #{response.errors.full_messages.to_sentence}"
           end
  else
    response = Response.where('lower(keyword) = ?', message.text.downcase).first
    text = if response 
             response.reply
           else
             'Im sorry i cannot proccess what did you say. :('
           end
  end
  message.reply(text: text)
end

Bot.on :postback do |postback|
  graph = Koala::Facebook::API.new(ENV['FB_ACCESS_TOKEN'])
  fbuser_obj = graph.get_object(postback.sender.fetch("id"))

  #create user
  user =  User.find_or_initialize_by(fbid: fbuser_obj['id'])
  user.mfbid = postback.sender.fetch("id")
  user.first_name = fbuser_obj.fetch('first_name')
  user.last_name = fbuser_obj.fetch('last_name')
  user.gender = fbuser_obj.fetch('gender')

  if user.save
    Rails.logger.info "POSTBACK Sender: #{user.fullname} saved!"
  else
    Rails.logger.warn "POSTBACK Sender: #{user.errors.full_messages.to_sentence} invalid!"
  end

  Facebook::Messenger::Profile.set({
    persistent_menu: [
      {
        locale: 'default',
        composer_input_disabled: false,
        call_to_actions: [
          {
            title: "Test View",
            type: "web_url",
            url: "https://first-class-bot.herokuapp.com/?test=#{user.mfbid}",
            messenger_extensions: true,
            webview_height_ratio: "tall"
          }
        ]
      }
    ]
  }, access_token: ENV['FB_PAGE_ACCESS_TOKEN'])

  postback.reply(text: "Ohhh wow! lets get started!")
end
