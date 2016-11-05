desc "This task is called by the Heroku scheduler add-on"
task :send_me_a_message_so_i_know_you_are_working => :environment do
  puts "Updating feed..."
  Facebook::Messenger::Bot.deliver(
    recipient: { 'id' => '1295793943798114' },
    message: {
      text: "hi im here"
    }
  )
end

task :send_reminders => :environment do
  User.send_reminders
end
