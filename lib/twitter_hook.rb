require "sinatra/base"

class TwitterHook < Sinatra::Base
  def self.twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  set(:notify) { production? }

  post "/twitter_notify" do
    last_post_title = app.settings.posts.last.title
    message = "Novo post no http://rafaelmacedo.com - #{last_post_title}"

    if settings.notify?
      settings.twitter_client.update message
    else
      message
    end
  end
end
