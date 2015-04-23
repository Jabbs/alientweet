require 'csv'
namespace :twitter do
  
  desc 'Do some twitter analysis'
  task :analyze_raw_data => :environment do
    
    scores = []; score_count = 0; score_total = 0; high_score = 0; low_score = 1000
    
    monday_count = 0; monday_score = 0; tuesday_count = 0; tuesday_score = 0; wednesday_count = 0; wednesday_score = 0; thursday_count = 0
    thursday_score = 0; friday_count = 0; friday_score = 0; saturday_count = 0; saturday_score = 0; sunday_count = 0; sunday_score = 0
    
    url_present_score = 0; url_present_count = 0; url_not_present_score = 0; url_not_present_count = 0
    quotation_true_count = 0; quotation_false_count = 0; quotation_true_score = 0; quotation_false_score = 0
    questionmark_true_count = 0; questionmark_false_count = 0; questionmark_true_score = 0; questionmark_false_score = 0
    mentions_false_count = 0; mentions_false_score = 0; mentions_true_count = 0; mentions_true_score = 0
    
    hour_7_count = 0; hour_8_count = 0; hour_9_count = 0; hour_10_count = 0; hour_11_count = 0; hour_12_count = 0
    hour_13_count = 0; hour_14_count = 0; hour_15_count = 0; hour_16_count = 0; hour_17_count = 0; hour_18_count = 0;
    hour_19_count = 0; hour_20_count = 0; hour_21_count = 0; hour_22_count = 0
    
    hour_7_score = 0; hour_8_score = 0; hour_9_score = 0; hour_10_score = 0; hour_11_score = 0; hour_12_score = 0
    hour_13_score = 0; hour_14_score = 0; hour_15_score = 0; hour_16_score = 0; hour_17_score = 0; hour_18_score = 0;
    hour_19_score = 0; hour_20_score = 0; hour_21_score = 0; hour_22_score = 0
        
    oct_2013_count = 0; oct_2013_score = 0; nov_2013_count = 0; nov_2013_score = 0; dec_2013_count = 0; dec_2013_score = 0
    jan_2014_count = 0; jan_2014_score = 0; feb_2014_count = 0; feb_2014_score = 0; mar_2014_count = 0; mar_2014_score = 0
    apr_2014_count = 0; apr_2014_score = 0; may_2014_count = 0; may_2014_score = 0; jun_2014_count = 0; jun_2014_score = 0
    jul_2014_count = 0; jul_2014_score = 0; aug_2014_count = 0; aug_2014_score = 0; sep_2014_count = 0; sep_2014_score = 0
    oct_2014_count = 0; oct_2014_score = 0; nov_2014_count = 0; nov_2014_score = 0; dec_2014_count = 0; dec_2014_score = 0
    jan_2015_count = 0; jan_2015_score = 0; feb_2015_count = 0; feb_2015_score = 0; mar_2015_count = 0; mar_2015_score = 0
    apr_2015_count = 0; apr_2015_score = 0
    
    CSV.foreach('lib/assets/path_to_your_csv.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      id = row[0]; link = row[1]; text = row[2]; datetime = row[3]; impressions = row[4]; engagements = row[5]; engagement_rate = row[6]
      retweets = row[7]; replies = row[8]; favorites = row[9]; clicks_profile = row[10]; clicks_url = row[11]; clicks_hashtag = row[12]
      detail_expands = row[13]
      
      # adjusting to CST time
      datetime = row[3].to_datetime
      datetime = datetime - 5.hours
      date = datetime.to_date
      # getting day and time
      day = datetime.strftime("%A")
      time = datetime.strftime("%H:%M")
      # character length
      char_length = text.split(" http").first.length
      # internal score
      score = (clicks_profile.to_i * 10) + (replies.to_i * 7) + (retweets.to_i * 5) + favorites.to_i + clicks_url.to_i + detail_expands.to_i
      score = row[25].to_i # normalized score
      scores << score.to_i
      
      if day == "Monday"
        monday_count += 1
        monday_score += score.to_i
      elsif day == "Tuesday"
        tuesday_count += 1
        tuesday_score += score.to_i
      elsif day == "Wednesday"
        wednesday_count += 1
        wednesday_score += score.to_i
      elsif day == "Thursday"
        thursday_count += 1
        thursday_score += score.to_i
      elsif day == "Friday"
        friday_count += 1
        friday_score += score.to_i
      elsif day == "Saturday"
        saturday_count += 1
        saturday_score += score.to_i
      elsif day == "Sunday"
        sunday_count += 1
        sunday_score += score.to_i
      end
      
      url_present = text.include?("http")
      quotation_present = text.include?('"')
      questionmark_present = text.include?("?")
      people_mentions = text.include?("@")
      
      if url_present == true
        url_present_score += score.to_i
        url_present_count += 1
      end
      if url_present == false
        url_not_present_score += score.to_i
        url_not_present_count += 1
      end
      
      if quotation_present == true
        quotation_true_count += 1
        quotation_true_score += score.to_i
      elsif quotation_present == false
        quotation_false_count += 1
        quotation_false_score += score.to_i
      end
      
      if questionmark_present == true
        questionmark_true_count += 1
        questionmark_true_score += score.to_i
      elsif questionmark_present == false
        questionmark_false_count += 1
        questionmark_false_score += score.to_i
      end
      
      if people_mentions == true
        mentions_false_count += 1
        mentions_false_score += score.to_i
      elsif people_mentions == false
        mentions_true_count += 1
        mentions_true_score += score.to_i
      end
      
      if time.present?
        hour = time.split(":").first
      else
        hour = "0"
      end
      case hour
      when "07"
        hour_7_count += 1
        hour_7_score += score.to_i
      when "08"
        hour_8_count += 1
        hour_8_score += score.to_i
      when "09"
        hour_9_count += 1
        hour_9_score += score.to_i
      when "10"
        hour_10_count += 1
        hour_10_score += score.to_i
      when "11"
        hour_11_count += 1
        hour_11_score += score.to_i
      when "12"
        hour_12_count += 1
        hour_12_score += score.to_i
      when "13"
        hour_13_count += 1
        hour_13_score += score.to_i
      when "14"
        hour_14_count += 1
        hour_14_score += score.to_i
      when "15"
        hour_15_count += 1
        hour_15_score += score.to_i
      when "16"
        hour_16_count += 1
        hour_16_score += score.to_i
      when "17"
        hour_17_count += 1
        hour_17_score += score.to_i
      when "18"
        hour_18_count += 1
        hour_18_score += score.to_i
      when "19"
        hour_19_count += 1
        hour_19_score += score.to_i
      when "20"
        hour_20_count += 1
        hour_20_score += score.to_i
      when "21"
        hour_21_count += 1
        hour_21_score += score.to_i
      when "22"
        hour_22_count += 1
        hour_22_score += score.to_i
      end
      
      if (Date.strptime("10/1/2013",'%m/%d/%Y')..Date.strptime("10/31/2013",'%m/%d/%Y')).cover?(date)
        oct_2013_count += 1
        oct_2013_score += score.to_i
      elsif (Date.strptime("11/1/2013",'%m/%d/%Y')..Date.strptime("11/30/2013",'%m/%d/%Y')).cover?(date)
        nov_2013_count += 1
        nov_2013_score += score.to_i
      elsif (Date.strptime("12/1/2013",'%m/%d/%Y')..Date.strptime("12/31/2013",'%m/%d/%Y')).cover?(date)
        dec_2013_count += 1
        dec_2013_score += score.to_i
      elsif (Date.strptime("1/1/2014",'%m/%d/%Y')..Date.strptime("1/31/2014",'%m/%d/%Y')).cover?(date)
        jan_2014_count += 1
        jan_2014_score += score.to_i
      elsif (Date.strptime("2/1/2014",'%m/%d/%Y')..Date.strptime("2/28/2014",'%m/%d/%Y')).cover?(date)
        feb_2014_count += 1
        feb_2014_score += score.to_i
      elsif (Date.strptime("3/1/2014",'%m/%d/%Y')..Date.strptime("3/31/2014",'%m/%d/%Y')).cover?(date)
        mar_2014_count += 1
        mar_2014_score += score.to_i
      elsif (Date.strptime("4/1/2014",'%m/%d/%Y')..Date.strptime("4/30/2014",'%m/%d/%Y')).cover?(date)
        apr_2014_count += 1
        apr_2014_score += score.to_i
      elsif (Date.strptime("5/1/2014",'%m/%d/%Y')..Date.strptime("5/31/2014",'%m/%d/%Y')).cover?(date)
        may_2014_count += 1
        may_2014_score += score.to_i
      elsif (Date.strptime("6/1/2014",'%m/%d/%Y')..Date.strptime("6/30/2014",'%m/%d/%Y')).cover?(date)
        jun_2014_count += 1
        jun_2014_score += score.to_i
      elsif (Date.strptime("7/1/2014",'%m/%d/%Y')..Date.strptime("7/31/2014",'%m/%d/%Y')).cover?(date)
        jul_2014_count += 1
        jul_2014_score += score.to_i
      elsif (Date.strptime("8/1/2014",'%m/%d/%Y')..Date.strptime("8/31/2014",'%m/%d/%Y')).cover?(date)
        aug_2014_count += 1
        aug_2014_score += score.to_i
      elsif (Date.strptime("9/1/2014",'%m/%d/%Y')..Date.strptime("9/30/2014",'%m/%d/%Y')).cover?(date)
        sep_2014_count += 1
        sep_2014_score += score.to_i
      elsif (Date.strptime("10/1/2014",'%m/%d/%Y')..Date.strptime("10/31/2014",'%m/%d/%Y')).cover?(date)
        oct_2014_count += 1
        oct_2014_score += score.to_i
      elsif (Date.strptime("11/1/2014",'%m/%d/%Y')..Date.strptime("11/30/2014",'%m/%d/%Y')).cover?(date)
        nov_2014_count += 1
        nov_2014_score += score.to_i
      elsif (Date.strptime("12/1/2014",'%m/%d/%Y')..Date.strptime("12/31/2014",'%m/%d/%Y')).cover?(date)
        dec_2014_count += 1
        dec_2014_score += score.to_i
      elsif (Date.strptime("1/1/2015",'%m/%d/%Y')..Date.strptime("1/31/2015",'%m/%d/%Y')).cover?(date)
        jan_2015_count += 1
        jan_2015_score += score.to_i
      elsif (Date.strptime("2/1/2015",'%m/%d/%Y')..Date.strptime("2/28/2015",'%m/%d/%Y')).cover?(date)
        feb_2015_count += 1
        feb_2015_score += score.to_i
      elsif (Date.strptime("3/1/2015",'%m/%d/%Y')..Date.strptime("3/31/2015",'%m/%d/%Y')).cover?(date)
        mar_2015_count += 1
        mar_2015_score += score.to_i
      elsif (Date.strptime("4/1/2015",'%m/%d/%Y')..Date.strptime("4/30/2015",'%m/%d/%Y')).cover?(date)
        apr_2015_count += 1
        apr_2015_score += score.to_i
      end
      

    end

    puts "--------------------------------------------------"
    puts "*** FORMAT ***"
    puts "--------------------------------------------------"
    puts "Average Score | Name of Attribute | Occurances/Count | Score"
    puts "--------------------------------------------------"
    puts "Q: What day of week gets the best score?"
    puts "--------------------------------------------------"
    puts "#{(monday_score.to_f/monday_count.to_f).round(1)} Avg Score | Monday | Count: #{monday_count} | Total Score: #{monday_score}"
    puts "#{(tuesday_score.to_f/tuesday_count.to_f).round(1)} Avg Score | Tuesday | Count: #{tuesday_count} | Total Score: #{tuesday_score}"
    puts "#{(wednesday_score.to_f/wednesday_count.to_f).round(1)} Avg Score | Wednesday | Count: #{wednesday_count} | Total Score: #{wednesday_score}"
    puts "#{(thursday_score.to_f/thursday_count.to_f).round(1)} Avg Score | Thursday | Count: #{thursday_count} | Total Score: #{thursday_score}"
    puts "#{(friday_score.to_f/friday_count.to_f).round(1)} Avg Score | Friday | Count: #{friday_count} | Total Score: #{friday_score}"
    puts "#{(saturday_score.to_f/saturday_count.to_f).round(1)} Avg Score | Saturday | Count: #{saturday_count} | Total Score: #{saturday_score}"
    puts "#{(sunday_score.to_f/sunday_count.to_f).round(1)} Avg Score | Sunday | Count: #{sunday_count} | Total Score: #{sunday_score}"
    puts "--------------------------------------------------"
    puts "Q: Which hour should I tweet?"
    puts "--------------------------------------------------"
    puts "#{(hour_7_score.to_f/hour_7_count.to_f).round(1)} Avg Score | Hour: 7:00-7:59am | Count: #{hour_7_count} | Total Score: #{hour_7_score}"
    puts "#{(hour_8_score.to_f/hour_8_count.to_f).round(1)} Avg Score | Hour: 8:00-8:59am | Count: #{hour_8_count} | Total Score: #{hour_8_score}"
    puts "#{(hour_9_score.to_f/hour_9_count.to_f).round(1)} Avg Score | Hour: 9:00-9:59am | Count: #{hour_9_count} | Total Score: #{hour_9_score}"
    puts "#{(hour_10_score.to_f/hour_10_count.to_f).round(1)} Avg Score | Hour: 10:00-10:59am | Count: #{hour_10_count} | Total Score: #{hour_10_score}"
    puts "#{(hour_11_score.to_f/hour_11_count.to_f).round(1)} Avg Score | Hour: 11:00-11:59am | Count: #{hour_11_count} | Total Score: #{hour_11_score}"
    puts "#{(hour_12_score.to_f/hour_12_count.to_f).round(1)} Avg Score | Hour: 12:00-12:59pm | Count: #{hour_12_count} | Total Score: #{hour_12_score}"
    puts "#{(hour_13_score.to_f/hour_13_count.to_f).round(1)} Avg Score | Hour: 1:00-1:59pm | Count: #{hour_13_count} | Total Score: #{hour_13_score}"
    puts "#{(hour_14_score.to_f/hour_14_count.to_f).round(1)} Avg Score | Hour: 2:00-2:59pm | Count: #{hour_14_count} | Total Score: #{hour_14_score}"
    puts "#{(hour_15_score.to_f/hour_15_count.to_f).round(1)} Avg Score | Hour: 3:00-3:59pm | Count: #{hour_15_count} | Total Score: #{hour_15_score}"
    puts "#{(hour_16_score.to_f/hour_16_count.to_f).round(1)} Avg Score | Hour: 4:00-4:59pm | Count: #{hour_16_count} | Total Score: #{hour_16_score}"
    puts "#{(hour_17_score.to_f/hour_17_count.to_f).round(1)} Avg Score | Hour: 5:00-5:59pm | Count: #{hour_17_count} | Total Score: #{hour_17_score}"
    puts "#{(hour_18_score.to_f/hour_18_count.to_f).round(1)} Avg Score | Hour: 6:00-6:59pm | Count: #{hour_18_count} | Total Score: #{hour_18_score}"
    puts "#{(hour_19_score.to_f/hour_19_count.to_f).round(1)} Avg Score | Hour: 7:00-7:59pm | Count: #{hour_19_count} | Total Score: #{hour_19_score}"
    puts "#{(hour_20_score.to_f/hour_20_count.to_f).round(1)} Avg Score | Hour: 8:00-8:59pm | Count: #{hour_20_count} | Total Score: #{hour_20_score}"
    puts "#{(hour_21_score.to_f/hour_21_count.to_f).round(1)} Avg Score | Hour: 9:00-9:59pm | Count: #{hour_21_count} | Total Score: #{hour_21_score}"
    puts "#{(hour_22_score.to_f/hour_22_count.to_f).round(1)} Avg Score | Hour: 10:00-10:59pm | Count: #{hour_22_count} | Total Score: #{hour_22_score}"
    puts "--------------------------------------------------"
    puts "Q: What do our scores look like month-to-month?"
    puts "--------------------------------------------------"
    puts "#{(oct_2013_score.to_f/oct_2013_count.to_f).round(1)} Avg Score | Oct 2013 | Count: #{oct_2013_count} | Total Score: #{oct_2013_score}"
    puts "#{(nov_2013_score.to_f/nov_2013_count.to_f).round(1)} Avg Score | Nov 2013 | Count: #{nov_2013_count} | Total Score: #{nov_2013_score}"
    puts "#{(dec_2013_score.to_f/dec_2013_count.to_f).round(1)} Avg Score | Dec 2013 | Count: #{dec_2013_count} | Total Score: #{dec_2013_score}"
    puts "#{(jan_2014_score.to_f/jan_2014_count.to_f).round(1)} Avg Score | Jan 2014 | Count: #{jan_2014_count} | Total Score: #{jan_2014_score}"
    puts "#{(feb_2014_score.to_f/feb_2014_count.to_f).round(1)} Avg Score | Feb 2014 | Count: #{feb_2014_count} | Total Score: #{feb_2014_score}"
    puts "#{(mar_2014_score.to_f/mar_2014_count.to_f).round(1)} Avg Score | Mar 2014 | Count: #{mar_2014_count} | Total Score: #{mar_2014_score}"
    puts "#{(apr_2014_score.to_f/apr_2014_count.to_f).round(1)} Avg Score | Apr 2014 | Count: #{apr_2014_count} | Total Score: #{apr_2014_score}"
    puts "#{(may_2014_score.to_f/may_2014_count.to_f).round(1)} Avg Score | May 2014 | Count: #{may_2014_count} | Total Score: #{may_2014_score}"
    puts "#{(jun_2014_score.to_f/jun_2014_count.to_f).round(1)} Avg Score | Jun 2014 | Count: #{jun_2014_count} | Total Score: #{jun_2014_score}"
    puts "#{(jul_2014_score.to_f/jul_2014_count.to_f).round(1)} Avg Score | Jul 2014 | Count: #{jul_2014_count} | Total Score: #{jul_2014_score}"
    puts "#{(aug_2014_score.to_f/aug_2014_count.to_f).round(1)} Avg Score | Aug 2014 | Count: #{aug_2014_count} | Total Score: #{aug_2014_score}"
    puts "#{(sep_2014_score.to_f/sep_2014_count.to_f).round(1)} Avg Score | Sep 2014 | Count: #{sep_2014_count} | Total Score: #{sep_2014_score}"
    puts "#{(oct_2014_score.to_f/oct_2014_count.to_f).round(1)} Avg Score | Oct 2014 | Count: #{oct_2014_count} | Total Score: #{oct_2014_score}"
    puts "#{(nov_2014_score.to_f/nov_2014_count.to_f).round(1)} Avg Score | Nov 2014 | Count: #{nov_2014_count} | Total Score: #{nov_2014_score}"
    puts "#{(dec_2014_score.to_f/dec_2014_count.to_f).round(1)} Avg Score | Dec 2014 | Count: #{dec_2014_count} | Total Score: #{dec_2014_score}"
    puts "#{(jan_2015_score.to_f/jan_2015_count.to_f).round(1)} Avg Score | Jan 2015 | Count: #{jan_2015_count} | Total Score: #{jan_2015_score}"
    puts "#{(feb_2015_score.to_f/feb_2015_count.to_f).round(1)} Avg Score | Feb 2015 | Count: #{feb_2015_count} | Total Score: #{feb_2015_score}"
    puts "#{(mar_2015_score.to_f/mar_2015_count.to_f).round(1)} Avg Score | Mar 2015 | Count: #{mar_2015_count} | Total Score: #{mar_2015_score}"
    puts "#{(apr_2015_score.to_f/apr_2015_count.to_f).round(1)} Avg Score | Apr 2015 | Count: #{apr_2015_count} | Total Score: #{apr_2015_score}"
    puts "--------------------------------------------------"
    puts "Q: Do quotations help?"
    puts "--------------------------------------------------"
    puts "#{(quotation_true_score.to_f/quotation_true_count.to_f).round(1)} Avg Score | Quotation TRUE | Count: #{quotation_true_count} | Total Score: #{quotation_true_score}"
    puts "#{(quotation_false_score.to_f/quotation_false_count.to_f).round(1)} Avg Score | Quotation FALSE | Count: #{quotation_false_count} | Total Score: #{quotation_false_score}"
    puts "--------------------------------------------------"
    puts "Q: Do questionmarks help?"
    puts "--------------------------------------------------"
    puts "#{(questionmark_true_score.to_f/questionmark_true_count.to_f).round(1)} Avg Score | Questionmark TRUE | Count: #{questionmark_true_count} | Total Score: #{questionmark_true_score}"
    puts "#{(questionmark_false_score.to_f/questionmark_false_count.to_f).round(1)} Avg Score | Questionmark FALSE | Count: #{questionmark_false_count} | Total Score: #{questionmark_false_score}"
    puts "--------------------------------------------------"
    puts "Q: Are mentions good or bad?"
    puts "--------------------------------------------------"
    puts "#{(mentions_true_score.to_f/mentions_true_count.to_f).round(1)} Avg Score | Mentions TRUE | Count: #{mentions_true_count} | Total Score: #{mentions_true_score}"
    puts "#{(mentions_false_score.to_f/mentions_false_count.to_f).round(1)} Avg Score | Mentions FALSE | Count: #{mentions_false_count} | Total Score: #{mentions_false_score}"
    puts "--------------------------------------------------"
    puts "Q: Does having a link help?"
    puts "--------------------------------------------------"
    puts "#{(url_present_score.to_f/url_present_count.to_f).round(1)} Avg Score | URL Present | Count: #{url_present_count} | Total Score: #{url_present_score}"
    puts "#{(url_not_present_score.to_f/url_not_present_count.to_f).round(1)} Avg Score | URL Not Present | Count: #{url_not_present_count} | Total Score: #{url_not_present_score}"
    puts "--------------------------------------------------"
    
    stats = DescriptiveStatistics::Stats.new(scores)
    puts "Mean: #{stats.mean}"
    puts "Median: #{stats.median}" 
    puts "Std Deviation: #{stats.standard_deviation}"
    puts "Highest score: #{stats.max}"
    puts "Lowest score: #{stats.min}"
    puts "--------------------------------------------------"
  end
  
  desc 'Do some twitter analysis'
  task :analyze => :environment do
    
    score_count = 0
    score_total = 0
    high_score = 0
    
    total_rows = 0
    monday_count = 0
    monday_score = 0
    tuesday_count = 0
    tuesday_score = 0
    wednesday_count = 0
    wednesday_score = 0
    thursday_count = 0
    thursday_score = 0
    friday_count = 0
    friday_score = 0
    
    hash_0_score = 0
    hash_1_score = 0
    hash_2_score = 0
    hash_3_score = 0
    hash_4_score = 0
    hash_0_count = 0
    hash_1_count = 0
    hash_2_count = 0
    hash_3_count = 0
    hash_4_count = 0
    
    hashtag_edchat_score = 0
    hashtag_edchat_count = 0
    hashtag_edtech_score = 0
    hashtag_edtech_count = 0
    hashtag_dataforstudents_score = 0
    hashtag_dataforstudents_count = 0
    hashtag_eddata_or_educationdata_score = 0
    hashtag_eddata_or_educationdata_count = 0
    
    conference_related_score = 0
    conference_related_count = 0
    image_present_score = 0
    image_present_count = 0
    tues_eleven_to_noon_score = 0
    tues_eleven_to_noon_count = 0
    url_present_score = 0
    url_present_count = 0
    url_not_present_score = 0
    url_not_present_count = 0
    
    quotation_true_count = 0
    quotation_false_count = 0
    quotation_true_score = 0
    quotation_false_score = 0
    
    questionmark_true_count = 0
    questionmark_false_count = 0
    questionmark_true_score = 0
    questionmark_false_score = 0
    
    hour_6_count = 0; hour_7_count = 0; hour_8_count = 0; hour_9_count = 0; hour_10_count = 0; hour_11_count = 0; hour_12_count = 0
    hour_13_count = 0; hour_14_count = 0; hour_15_count = 0; hour_16_count = 0; hour_17_count = 0
    
    hour_6_score = 0; hour_7_score = 0; hour_8_score = 0; hour_9_score = 0; hour_10_score = 0; hour_11_score = 0; hour_12_score = 0
    hour_13_score = 0; hour_14_score = 0; hour_15_score = 0; hour_16_score = 0; hour_17_score = 0
    
    mentions_false_count = 0
    mentions_false_score = 0
    mentions_true_count = 0
    mentions_true_score = 0
    
    mention_news_count = 0
    mention_news_score = 0
    mention_author_count = 0
    mention_author_score = 0
    mention_other_count = 0
    mention_other_score = 0
    
    topic_technology_count = 0
    topic_technology_score = 0
    topic_privacy_count = 0
    topic_privacy_score = 0
    topic_data_count = 0
    topic_data_score = 0
    topic_education_count = 0
    topic_education_score = 0
    
    content_type_website_count = 0
    content_type_website_score = 0
    content_type_blog_count = 0
    content_type_blog_score = 0
    content_type_article_count = 0
    content_type_article_score = 0
    content_type_video_count = 0
    content_type_video_score = 0
    
    content_source_edsurge_count = 0
    content_source_edsurge_score = 0
    content_source_edweek_count = 0
    content_source_edweek_score = 0
    content_source_huffington_count = 0
    content_source_huffington_score = 0
    content_source_npr_count = 0
    content_source_npr_score = 0
    content_source_theatlantic_count = 0
    content_source_theatlantic_score = 0
    
    oct_2013_count = 0
    oct_2013_score = 0
    nov_2013_count = 0
    nov_2013_score = 0
    dec_2013_count = 0
    dec_2013_score = 0
    jan_2014_count = 0
    jan_2014_score = 0
    feb_2014_count = 0
    feb_2014_score = 0
    mar_2014_count = 0
    mar_2014_score = 0
    apr_2014_count = 0
    apr_2014_score = 0
    may_2014_count = 0
    may_2014_score = 0
    jun_2014_count = 0
    jun_2014_score = 0
    jul_2014_count = 0
    jul_2014_score = 0
    aug_2014_count = 0
    aug_2014_score = 0
    sep_2014_count = 0
    sep_2014_score = 0
    oct_2014_count = 0
    oct_2014_score = 0
    nov_2014_count = 0
    nov_2014_score = 0
    dec_2014_count = 0
    dec_2014_score = 0
    jan_2015_count = 0
    jan_2015_score = 0
    feb_2015_count = 0
    feb_2015_score = 0
    mar_2015_count = 0
    mar_2015_score = 0
    apr_2015_count = 0
    apr_2015_score = 0
    
    scores = []
    
    CSV.foreach('lib/assets/tweet_activity_metrics_10_18_13_to_4_17_15.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      # datetime = row[3].to_datetime
      # datetime = datetime - 5.hours # adjusting to CST time
      # day = datetime.strftime("%A")
      # time = datetime.strftime("%H:%M")
      
      # text = row[2]
      # puts text.split(" http").first.length
      # puts text.count("#edchat")
      # puts text.include?("#eddata") || text.include?("#EdData") || text.include?("#edData") || text.include?("#EDDATA")
      
      
      id = row[0]
      link = row[1]
      text = row[2]
      datetime_utc = row[3]
      date_cst = row[4]
      score = row[5]
      followers = row[6]
      impressions = row[7]
      engagements = row[8]
      engagement_rate = row[9]
      retweets = row[10]
      replies = row[11]
      favorites = row[12]
      clicks_profile = row[13]
      clicks_url = row[14]
      clicks_hashtag = row[15]
      detail_expands = row[16]
      time = row[17]
      day = row[18]
      char_length = row[19]
      topic_technology = row[20]
      topic_privacy = row[21]
      topic_data = row[22]
      topic_education = row[23]
      content_type_website = row[24]
      content_type_blog = row[25]
      content_type_article = row[26]
      content_type_video = row[27]
      content_source = row[28]
      hashtags_count = row[29]
      hashtag_edchat = row[30]
      hashtag_edtech = row[31]
      hashtag_dataforstudents = row[32]
      hashtag_eddata_or_educationdata = row[33]
      conference_related = row[34]
      image_present = row[35]
      tues_eleven_to_noon = row[36]
      url_present = row[37]
      quotation_present = row[38]
      questionmark_present = row[39]
      people_mentions_count = row[40]
      people_news = row[41]
      people_author = row[42]
      people_other = row[43]
      hand_scored = row[44]
      normalized_score = row[46]
      
      # using normalized score:
      score = normalized_score
      scores << score.to_i
      
      # counting rows scored
      total_rows += 1 if hand_scored == "X"
      
      if hashtags_count == "0"
        hash_0_count += 1
        hash_0_score += score.to_i
      elsif hashtags_count == "1"
        hash_1_count += 1
        hash_1_score += score.to_i
      elsif hashtags_count == "2"
        hash_2_count += 1
        hash_2_score += score.to_i
      elsif hashtags_count == "3"
        hash_3_count += 1
        hash_3_score += score.to_i
      elsif hashtags_count == "4"
        hash_4_count += 1
        hash_4_score += score.to_i
      end
      
      if day == "Monday"
        monday_count += 1
        monday_score += score.to_i
      elsif day == "Tuesday"
        tuesday_count += 1
        tuesday_score += score.to_i
      elsif day == "Wednesday"
        wednesday_count += 1
        wednesday_score += score.to_i
      elsif day == "Thursday"
        thursday_count += 1
        thursday_score += score.to_i
      elsif day == "Friday"
        friday_count += 1
        friday_score += score.to_i
      end
      
      if hashtag_edchat == "TRUE"
        hashtag_edchat_score += score.to_i
        hashtag_edchat_count += 1
      end
      if hashtag_edtech == "TRUE"
        hashtag_edtech_score += score.to_i
        hashtag_edtech_count += 1
      end
      if hashtag_dataforstudents == "TRUE"
        hashtag_dataforstudents_score += score.to_i
        hashtag_dataforstudents_count += 1
      end
      if hashtag_eddata_or_educationdata == "TRUE"
        hashtag_eddata_or_educationdata_score += score.to_i
        hashtag_eddata_or_educationdata_count += 1
      end
      
      if conference_related == "X"
        conference_related_score += score.to_i
        conference_related_count += 1
      end
      if image_present == "X"
        image_present_score += score.to_i
        image_present_count += 1
      end
      if tues_eleven_to_noon == "TRUE"
        tues_eleven_to_noon_score += score.to_i
        tues_eleven_to_noon_count += 1
      end
      if url_present == "TRUE"
        url_present_score += score.to_i
        url_present_count += 1
      end
      if url_present == "FALSE"
        url_not_present_score += score.to_i
        url_not_present_count += 1
      end
      
      if quotation_present == "TRUE"
        quotation_true_count += 1
        quotation_true_score += score.to_i
      elsif quotation_present == "FALSE"
        quotation_false_count += 1
        quotation_false_score += score.to_i
      end
      
      if questionmark_present == "TRUE"
        questionmark_true_count += 1
        questionmark_true_score += score.to_i
      elsif questionmark_present == "FALSE"
        questionmark_false_count += 1
        questionmark_false_score += score.to_i
      end
      
      if time.present?
        hour = time.split(":").first
      else
        hour = "0"
      end
      case hour
      when "6"
        hour_6_count += 1
        hour_6_score += score.to_i
      when "7"
        hour_7_count += 1
        hour_7_score += score.to_i
      when "8"
        hour_8_count += 1
        hour_8_score += score.to_i
      when "9"
        hour_9_count += 1
        hour_9_score += score.to_i
      when "10"
        hour_10_count += 1
        hour_10_score += score.to_i
      when "11"
        hour_11_count += 1
        hour_11_score += score.to_i
      when "12"
        hour_12_count += 1
        hour_12_score += score.to_i
      when "13"
        hour_13_count += 1
        hour_13_score += score.to_i
      when "14"
        hour_14_count += 1
        hour_14_score += score.to_i
      when "15"
        hour_15_count += 1
        hour_15_score += score.to_i
      when "16"
        hour_16_count += 1
        hour_16_score += score.to_i
      when "17"
        hour_17_count += 1
        hour_17_score += score.to_i
      end
      
      if people_mentions_count == "0"
        mentions_false_count += 1
        mentions_false_score += score.to_i
      else
        mentions_true_count += 1
        mentions_true_score += score.to_i
      end
      
      if people_news == "X"
        mention_news_count += 1
        mention_news_score += score.to_i
      end
      if people_author == "X"
        mention_author_count += 1
        mention_author_score += score.to_i
      end
      if people_other == "X"
        mention_other_count += 1
        mention_other_score += score.to_i
      end
      
      if topic_technology == "X"
        topic_technology_count += 1
        topic_technology_score += score.to_i
      end
      if topic_privacy == "X"
        topic_privacy_count += 1
        topic_privacy_score += score.to_i
      end
      if topic_data == "X"
        topic_data_count += 1
        topic_data_score += score.to_i
      end
      if topic_education == "X"
        topic_education_count += 1
        topic_education_score += score.to_i
      end
            
      if content_type_website == "X"
        content_type_website_count += 1
        content_type_website_score += score.to_i
      elsif content_type_blog == "X"
        content_type_blog_count += 1
        content_type_blog_score += score.to_i
      elsif content_type_article == "X"
        content_type_article_count += 1
        content_type_article_score += score.to_i
      elsif content_type_video == "X"
        content_type_video_count += 1
        content_type_video_score += score.to_i
      end
      
      case content_source
      when "edSurge"
        content_source_edsurge_count += 1
        content_source_edsurge_score += score.to_i
      when "Education Week"
        content_source_edweek_count += 1
        content_source_edweek_score += score.to_i
      when "Huffington Post"
        content_source_huffington_count += 1
        content_source_huffington_score += score.to_i
      when "NPR"
        content_source_npr_count += 1
        content_source_npr_score += score.to_i
      when "The Atlantic"
        content_source_theatlantic_count += 1
        content_source_theatlantic_score += score.to_i
      end

      if (Date.strptime("10/1/2013",'%m/%d/%Y')..Date.strptime("10/31/2013",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        oct_2013_count += 1
        oct_2013_score += score.to_i
      elsif (Date.strptime("11/1/2013",'%m/%d/%Y')..Date.strptime("11/30/2013",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        nov_2013_count += 1
        nov_2013_score += score.to_i
      elsif (Date.strptime("12/1/2013",'%m/%d/%Y')..Date.strptime("12/31/2013",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        dec_2013_count += 1
        dec_2013_score += score.to_i
      elsif (Date.strptime("1/1/2014",'%m/%d/%Y')..Date.strptime("1/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        jan_2014_count += 1
        jan_2014_score += score.to_i
      elsif (Date.strptime("2/1/2014",'%m/%d/%Y')..Date.strptime("2/28/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        feb_2014_count += 1
        feb_2014_score += score.to_i
      elsif (Date.strptime("3/1/2014",'%m/%d/%Y')..Date.strptime("3/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        mar_2014_count += 1
        mar_2014_score += score.to_i
      elsif (Date.strptime("4/1/2014",'%m/%d/%Y')..Date.strptime("4/30/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        apr_2014_count += 1
        apr_2014_score += score.to_i
      elsif (Date.strptime("5/1/2014",'%m/%d/%Y')..Date.strptime("5/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        may_2014_count += 1
        may_2014_score += score.to_i
      elsif (Date.strptime("6/1/2014",'%m/%d/%Y')..Date.strptime("6/30/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        jun_2014_count += 1
        jun_2014_score += score.to_i
      elsif (Date.strptime("7/1/2014",'%m/%d/%Y')..Date.strptime("7/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        jul_2014_count += 1
        jul_2014_score += score.to_i
      elsif (Date.strptime("8/1/2014",'%m/%d/%Y')..Date.strptime("8/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        aug_2014_count += 1
        aug_2014_score += score.to_i
      elsif (Date.strptime("9/1/2014",'%m/%d/%Y')..Date.strptime("9/30/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        sep_2014_count += 1
        sep_2014_score += score.to_i
      elsif (Date.strptime("10/1/2014",'%m/%d/%Y')..Date.strptime("10/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        oct_2014_count += 1
        oct_2014_score += score.to_i
      elsif (Date.strptime("11/1/2014",'%m/%d/%Y')..Date.strptime("11/30/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        nov_2014_count += 1
        nov_2014_score += score.to_i
      elsif (Date.strptime("12/1/2014",'%m/%d/%Y')..Date.strptime("12/31/2014",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        dec_2014_count += 1
        dec_2014_score += score.to_i
      elsif (Date.strptime("1/1/2015",'%m/%d/%Y')..Date.strptime("1/31/2015",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        jan_2015_count += 1
        jan_2015_score += score.to_i
      elsif (Date.strptime("2/1/2015",'%m/%d/%Y')..Date.strptime("2/28/2015",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        feb_2015_count += 1
        feb_2015_score += score.to_i
      elsif (Date.strptime("3/1/2015",'%m/%d/%Y')..Date.strptime("3/31/2015",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        mar_2015_count += 1
        mar_2015_score += score.to_i
      elsif (Date.strptime("4/1/2015",'%m/%d/%Y')..Date.strptime("4/30/2015",'%m/%d/%Y')).cover?(Date.strptime(date_cst.to_s,'%m/%d/%y'))
        apr_2015_count += 1
        apr_2015_score += score.to_i
      end
      
      # puts text.gsub("Š—", "").gsub("Š—È", "'").gsub("È", "'")
      
    end
    
    @stats = DescriptiveStatistics::Stats.new(scores)
    
    def calculate_results(score, count, name)
      if score == 0
        avg = "n/a"
      else
        avg = (score.to_f/count.to_f).round(1)
      end
      if avg == "n/a"
        diff_text = "n/a"
      elsif avg > @stats.mean
        diff = ((avg.to_f/@stats.mean.to_f - 1) * 100).round
        diff_text = "+ #{diff}%"
      else
        diff = ((@stats.mean.to_f/avg.to_f - 1) * 100).round
        diff_text = "- #{diff}%"
      end
      "#{avg} Avg Score | #{name} | Count: #{count} | Total Score: #{score} | #{diff_text}"
    end
    
    puts "RESULTS:"
    puts "--------------------------------------------------"
    puts "*** FORMAT ***"
    puts "--------------------------------------------------"
    puts "Average Score | Name of Attribute | Occurances/Count | Score"
    puts "--------------------------------------------------"
    puts "Q: Which day gets the best score?"
    puts "--------------------------------------------------"
    puts calculate_results(monday_score, monday_count, "Monday")
    puts calculate_results(tuesday_score, tuesday_count, "Tuesday")
    puts calculate_results(wednesday_score, wednesday_count, "Wednesday")
    puts calculate_results(thursday_score, thursday_count, "Thursday")
    puts calculate_results(friday_score, friday_count, "Friday")
    puts "--------------------------------------------------"
    puts "Q: Ideal # of hashtags?"
    puts "--------------------------------------------------"
    puts calculate_results(hash_0_score, hash_0_count, "0 Hashtags")
    puts calculate_results(hash_1_score, hash_1_count, "1 Hashtag")
    puts calculate_results(hash_2_score, hash_2_count, "2 Hashtags")
    puts calculate_results(hash_3_score, hash_3_count, "3 Hashtags")
    puts calculate_results(hash_4_score, hash_4_count, "4 Hashtags")
    puts "--------------------------------------------------"
    puts "Q: Which hashtags work?"
    puts "--------------------------------------------------"
    puts calculate_results(hashtag_edchat_score, hashtag_edchat_count, "Hashtag: edchat")
    puts calculate_results(hashtag_edtech_score, hashtag_edtech_count, "Hashtag: edtech")
    puts calculate_results(hashtag_dataforstudents_score, hashtag_dataforstudents_count, "Hashtag: dataforstudents")
    puts calculate_results(hashtag_eddata_or_educationdata_score, hashtag_eddata_or_educationdata_count, "Hashtag: eddata or educationdata")
    puts "--------------------------------------------------"
    puts "Q: Do quotations help?"
    puts "--------------------------------------------------"
    puts calculate_results(quotation_true_score, quotation_true_count, "Quotation TRUE")
    puts calculate_results(quotation_false_score, quotation_false_count, "Quotation FALSE")
    puts "--------------------------------------------------"
    puts "Q: Do questionmarks help?"
    puts "--------------------------------------------------"
    puts calculate_results(questionmark_true_score, questionmark_true_count, "Questionmark TRUE")
    puts calculate_results(questionmark_false_score, questionmark_false_count, "Questionmark FALSE")
    puts "--------------------------------------------------"
    puts "Q: Which hour should I tweet?"
    puts "--------------------------------------------------"
    puts calculate_results(hour_6_score, hour_6_count, "Hour: 6:00-6:59am")
    puts calculate_results(hour_7_score, hour_7_count, "Hour: 7:00-7:59am")
    puts calculate_results(hour_8_score, hour_8_count, "Hour: 8:00-8:59am")
    puts calculate_results(hour_9_score, hour_9_count, "Hour: 9:00-9:59am")
    puts calculate_results(hour_10_score, hour_10_count, "Hour: 10:00-10:59am")
    puts calculate_results(hour_11_score, hour_11_count, "Hour: 11:00-11:59am")
    puts calculate_results(hour_12_score, hour_12_count, "Hour: 12:00-12:59pm")
    puts calculate_results(hour_13_score, hour_13_count, "Hour: 1:00-1:59pm")
    puts calculate_results(hour_14_score, hour_14_count, "Hour: 2:00-2:59pm")
    puts calculate_results(hour_15_score, hour_15_count, "Hour: 3:00-3:59pm")
    puts calculate_results(hour_16_score, hour_16_count, "Hour: 4:00-4:59pm")
    puts calculate_results(hour_17_score, hour_17_count, "Hour: 5:00-5:59pm")
    puts "--------------------------------------------------"       
    puts "Q: Are mentions good or bad?"
    puts "--------------------------------------------------"
    puts calculate_results(mentions_true_score, mentions_true_count, "Mentions TRUE")
    puts calculate_results(mentions_false_score, mentions_false_count, "Mentions FALSE")
    puts "--------------------------------------------------"
    puts "Q: Which types of mentions work well?"
    puts "--------------------------------------------------"
    puts calculate_results(mention_news_score, mention_news_count, "Mentions News")
    puts calculate_results(mention_author_score, mention_author_count, "Mentions Author")
    puts calculate_results(mention_other_score, mention_other_count, "Mentions Other")  
    puts "--------------------------------------------------"
    puts "Q: Which topics work well?"
    puts "--------------------------------------------------"
    puts calculate_results(topic_technology_score, topic_technology_count, "Topic: Technology")  
    puts calculate_results(topic_privacy_score, topic_privacy_count, "Topic: Privacy")  
    puts calculate_results(topic_data_score, topic_data_count, "Topic: Data")  
    puts calculate_results(topic_education_score, topic_education_count, "Topic: Education")
    puts "--------------------------------------------------"
    puts "Q: What type of content works well?"
    puts "--------------------------------------------------"
    puts calculate_results(content_type_website_score, content_type_website_count, "Content Type: Website")
    puts calculate_results(content_type_blog_score, content_type_blog_count, "Content Type: Blog")
    puts calculate_results(content_type_article_score, content_type_article_count, "Content Type: Article")
    puts calculate_results(content_type_video_score, content_type_video_count, "Content Type: Video")
    puts "--------------------------------------------------"
    puts "Q: Which content sources work well?"
    puts "--------------------------------------------------"
    puts calculate_results(content_source_edsurge_score, content_source_edsurge_count, "Content Source: edSurge")
    puts calculate_results(content_source_edweek_score, content_source_edweek_count, "Content Source: Education Week")
    puts calculate_results(content_source_huffington_score, content_source_huffington_count, "Content Source: Huffington Post")
    puts calculate_results(content_source_npr_score, content_source_npr_count, "Content Source: NPR")
    puts calculate_results(content_source_theatlantic_score, content_source_theatlantic_count, "Content Source: The Atlantic")
    puts "--------------------------------------------------"
    puts "Q: What do our scores look like month-to-month?"
    puts "--------------------------------------------------"
    puts calculate_results(oct_2013_score, oct_2013_count, "Oct 2013")
    puts calculate_results(nov_2013_score, nov_2013_count, "Nov 2013")
    puts calculate_results(dec_2013_score, dec_2013_count, "Dec 2013")
    puts calculate_results(jan_2014_score, jan_2014_count, "Jan 2014")
    puts calculate_results(feb_2014_score, feb_2014_count, "Feb 2014")
    puts calculate_results(mar_2014_score, mar_2014_count, "Mar 2014")
    puts calculate_results(apr_2014_score, apr_2014_count, "Apr 2014")
    puts calculate_results(may_2014_score, may_2014_count, "May 2014")
    puts calculate_results(jun_2014_score, jun_2014_count, "Jun 2014")
    puts calculate_results(jul_2014_score, jul_2014_count, "Jul 2014")
    puts calculate_results(aug_2014_score, aug_2014_count, "Aug 2014")
    puts calculate_results(sep_2014_score, sep_2014_count, "Sep 2014")
    puts calculate_results(oct_2014_score, oct_2014_count, "Oct 2014")
    puts calculate_results(nov_2014_score, nov_2014_count, "Nov 2014")
    puts calculate_results(dec_2014_score, dec_2014_count, "Dec 2014")
    puts calculate_results(jan_2015_score, jan_2015_count, "Jan 2015")
    puts calculate_results(feb_2015_score, feb_2015_count, "Feb 2015")
    puts calculate_results(mar_2015_score, mar_2015_count, "Mar 2015")
    puts calculate_results(apr_2015_score, apr_2015_count, "Apr 2015")
    puts "--------------------------------------------------"
    puts "Some other data..."
    puts "--------------------------------------------------"
    puts calculate_results(conference_related_score, conference_related_count, "Conference Related")
    puts calculate_results(image_present_score, image_present_count, "Image Present")
    puts calculate_results(tues_eleven_to_noon_score, tues_eleven_to_noon_count, "During Chat (Tues 11-Noon)")
    puts calculate_results(url_present_score, url_present_count, "URL Present")
    puts calculate_results(url_not_present_score, url_not_present_count, "URL Not Present")
    puts "--------------------------------------------------"
    puts "Mean: #{@stats.mean}"
    puts "Median: #{@stats.median}" 
    puts "Std Deviation: #{@stats.standard_deviation}"
    puts "Highest score: #{@stats.max}"
    puts "Lowest score: #{@stats.min}"
    puts "--------------------------------------------------"
    
  end
end