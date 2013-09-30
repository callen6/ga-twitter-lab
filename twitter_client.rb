require 'twitter'
require 'dotenv'
require 'pry'

Dotenv.load


@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret    = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

binding.pry

puts "What user do you want to know about?"
handle_want = gets.chomp.downcase
t_handle = client.user(handle_want)

p "What would you like to know about @#{handle_want}? Select from Recent Tweets, Friend List, User Details, Lists, or Favorited Tweets"
want_to_know = gets.chomp.downcase.to_s

def query(want_to_know, t_handle)
	if want_to_know == "recent tweets"
		client.user_timeline(t_handle).each {|bit| bit.text }
		end
	else
		return "Come again?"
	end

end
# binding.pry