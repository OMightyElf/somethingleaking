desc "This task is called by the Heroku scheduler add-on"
task :send_me_a_message_so_i_know_you_are_working => :environment do
  Facebook::Messenger::Bot.deliver(
    recipient: { 'id' => '1295793943798114' },
    message: {
      text: "yeah i'm still alive"
    }
  )
end

task :crawl_page => :environment do
  TIXCRAFT_URL = "https://tixcraft.com/activity/detail/17_JRI_TP"

  page = Nokogiri::HTML(open(TIXCRAFT_URL))
  rows = page.css('ul.btn li')

  if rows.length > 2
    Facebook::Messenger::Bot.deliver(
      recipient: { 'id' => '1295793943798114' },
      message: {
        text: "還在等什麼！！！快搶票！！！！！！！"
      }
    )
  end
end
