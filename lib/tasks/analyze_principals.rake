require 'csv'
namespace :principals do
  desc 'Populate database with twitter_accounts'
  task :get_states => :environment do
    
    x = []
    CSV.foreach('lib/assets/principal-pipeline.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      org_name = row[4]
      parenthesis = org_name[/\(.*?\)/]
      parenthesis = parenthesis[1...-1]
      if parenthesis && parenthesis.length == 2
        x << parenthesis
        puts parenthesis
      end
    end
    x
    
    principal_states = ["AL", "AL", "AR", "AZ", "CA", "CA", "CT", "CT", "FL", "FL", "FL", "FL", "GA", "GA", "GA", "GA", "GA", 
      "GA", "GA", "GA", "GA", "IA", "IA", "IA", "IA", "IA", "IA", "IA", "IL", "IL", "IL", "IL", "IL", "IL", "IL", "IL", "IL", 
      "IN", "KY", "KY", "LA", "MA", "MA", "MA", "MA", "MA", "MD", "MD", "MI", "MI", "MI", "MN", "MO", "MO", "MO", "MO", "MO", 
      "MO", "MO", "MO", "MO", "MO", "MS", "NC", "NE", "NE", "NJ", "NJ", "NJ", "NJ", "NJ", "NY", "NY", "OH", "OH", "OH", "OH", 
      "OH", "PA", "PA", "PA", "PA", "PA", "RI", "RI", "SC", "SC", "TN", "TN", "TX", "TX", "TX", "TX", "TX", "TX", "VA", "WA", 
      "WA", "WI", "WI"]
    
    
  end
end