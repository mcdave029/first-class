include Facebook::Messenger

Bot.on :message do |message|
  Rails.logger.info "ID: #{message.id}, Sender: #{message.sender}"
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
