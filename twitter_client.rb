require 'twitter'
require 'dotenv'
require 'pry'

Dotenv.load


# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret    = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_SECRET"]
# end
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


# topics = ["justin", "bieber", "miley", "cyrus"]
# beliebers =[]
# i = 0

# client.filter(track: topics.join(',')) do |tweet|
# tweet.lang == 'en'
# i += 1
# beliebers << tweet.attrs[:user][:screen_name]
# puts "#{i} beliebers are among us"
# break if i > 100
# end

topic = "obama"
obama_tweets = []
i = 0

client.filter(track: topic) do |tweet|
  if tweet.lang == 'en'
    i += 1
    obama_tweets << {username: tweet.attrs[:user][:screen_name], tweet: tweet.text}
    puts "#{i} tweets gathered"
  end
break if i >= 100
end

words = []

words = obama_tweets.map do |tweet_datum|
	tweet_datum[:tweet].split(' ')
end

words.flatten!

frequencies = {}

words.each do |word|
	frequencies[word.to_sym] ||= 0 	# look in the freq hash for [this key value] or assign to 0
	frequencies[word.to_sym] += 1 	# if it finds the word, increment the count up one
binding.pry
end

# puts "What user do you want to know about?"
# handle_want = gets.chomp.downcase
# t_handle = client.user(handle_want)

# p "What would you like to know about @#{handle_want}? Select from Recent Tweets, 
# 	Friend List, User Details, Lists, or Favorited Tweets"
# 	want_to_know = gets.chomp.downcase.to_s

# def query(want_to_know, t_handle)
# 	if want_to_know == "recent tweets"
# 		client.user_timeline(t_handle).each {|bit| puts bit.text }
# 	elsif want_to_know == "friend list"
# 		client.friends(t_handle).each { |bit| puts bit.___ }
# 	elsif want_to_know == "user details"

# 	elsif want_to_know == "lists"

# 	elsif want_to_know == "favorited tweets"
# 	else	
# 		return "Come again?"
# 	end
# end
