include Facebook::Messenger

Bot.on :message do |message|
  arr_string = message.text.split(';')
  able_to_teach = arr_string.count == 2 && arr_string[0]&.include?('keyword:') && arr_string[1]&.include?('reply:')
  if able_to_teach
    response = Response.new(keyword: arr_string[0], reply: arr_string[1])
    text = if response.save
             "Got it thanks. now try #{response.keyword} to see if its working. :D"
           else
             "Im sorry but #{response.errors.full_messages.to_sentence}"
           end
  else
    response = Response.find_by(keyword: message.text)
    text = if response 
             response.reply
           else
             'Im sorry i cannot proccess what did you say. :('
           end
  end
  message.reply(text: text)
end
