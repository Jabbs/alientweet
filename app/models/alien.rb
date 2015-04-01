class Alien < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  require 'json'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'

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
    resource.create_summarization(sentences: summarization["sentences"])
  end
  
  def self.create_hashtagging(resource)
    parameters = {"url" => resource.url}
    hashtagging = Alien.call_api("hashtags", parameters)
    resource.create_hashtagging(hashtags: hashtagging["hashtags"])
  end
  
end
