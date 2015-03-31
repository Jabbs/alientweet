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
  
  def self.create_extraction(resource)
    parameters = {"url" => resource.url}
    extraction = Alien.call_api("extract", parameters)
    resource.create_extraction(title: extraction["title"], article: extraction["article"], author: extraction["author"],
                               videos: extraction["videos"], feeds: extraction["feeds"])
  end
  
  def self.create_summarization(resource)
    parameters = {"url" => resource.url}
    summarization = Alien.call_api("summarize", parameters)
    resource.create_summarization!(text: summarization["text"], sentences: summarization["sentences"])
    logger.debug "****** #{summarization["sentences"]}"
  end

  parameters = {"url" => "http://www.bbc.com/sport/0/football/25912393"}
  parameters = {"text" => "John is a very good football player!"}
  
  summarize = Alien.call_api("summarize", parameters)
  extraction = Alien.call_api("extract", parameters)

  sentiment = Alien.call_api("sentiment", parameters)
  language = Alien.call_api("language", parameters)

  puts "Sentiment: #{sentiment["polarity"]} (#{sentiment["polarity_confidence"]})"
  puts "Language: #{language["lang"]} (#{language["confidence"]})"
end
