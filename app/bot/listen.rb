require "facebook/messenger"
require "open-uri"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe

# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.seq         # => 73
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'
# message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
Bot.on :message do |message|
  if message.text == "/there?"
    Bot.deliver(
      recipient: { 'id' => ENV["ADELE_ID"] },
      message: {
        text: "still crawling!"
      }
    )
  elsif message.text == "/check"
    TIXCRAFT_URL = "https://tixcraft.com/activity/detail/17_JRI_TP"

    page = Nokogiri::HTML(open(TIXCRAFT_URL))
    buttons = page.css('ul.btn li')

    buttons_we_now_have = buttons.map { |button|
      button.text()
    }.join(", ")

    Facebook::Messenger::Bot.deliver(
      recipient: { 'id' => ENV["ADELE_ID"] },
      message: {
        text: buttons_we_now_have
      }
    )
  else
    Bot.deliver(
      recipient: { 'id' => ENV["ADELE_ID"] },
      message: {
        text: "did u just say #{message.text}?"
      }
    )
  end
end
