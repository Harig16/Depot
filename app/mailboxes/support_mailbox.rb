class SupportMailbox < ApplicationMailbox
  def process
    puts "START SupportMailBox#process:"
    puts "From    :  #{mail.from_address}"
    puts "Subject :  #{mail.subject}"
    puts "Body :  #{mail.body}"
    puts "END SupportMailBox#process:"
  end
end
