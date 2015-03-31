class Alien < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  require 'json'

  def self.call_api(endpoint, parameters)
    url = URI.parse("https://api.aylien.com/api/v1/#{endpoint}")
    headers = {
        "Accept"                           =>   "application/json",
        "X-AYLIEN-TextAPI-Application-ID"  =>   ENV['APPLICATION_ID'],
        "X-AYLIEN-TextAPI-Application-Key" =>   ENV['APPLICATION_KEY']
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url.request_uri)
    request.initialize_http_header(headers)
    request.set_form_data(parameters)

    response = http.request(request)

    JSON.parse response.body
  end

  parameters = {"text" => "John is a very good football player!"}

  sentiment = call_api("sentiment", parameters)
  language = call_api("language", parameters)

  puts "Sentiment: #{sentiment["polarity"]} (#{sentiment["polarity_confidence"]})"
  puts "Language: #{language["lang"]} (#{language["confidence"]})"
end
