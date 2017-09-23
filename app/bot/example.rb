include Facebook::Messenger

Bot.on :message do |message|
  text = case message.text
         when 'Mc Dave' then 'Oops, thats private i cannot tell anyone about my creator.'
         else
           'Im, sorry i just dont know how to response.'
         end

  message.reply(text: text)
end
