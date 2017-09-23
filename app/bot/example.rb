include Facebook::Messenger

Bot.on :message do |message|
  response = Response.find_by(keyword: message.text)
  text = if response 
           response.reply
         else
           'Im sorry i cannot proccess what did you say. :('
         end

  message.reply(text: text)
end
