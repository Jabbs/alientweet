desc "Creates tweets from existing resources"
task :make_tweets => :environment do
  Resource.all.each do |resource|
    5.times do
      approved = [true, false].shuffle.first
      if approved == true
        last_approved_at = DateTime.now
        placement_id = rand(1..12)
      else
        last_approved_at = nil
      end
      sent = [true, false].shuffle.first
      if sent == true
        last_sent_at = DateTime.now
        cleared = true
      else
        last_sent_at = nil
        cleared = false
      end
      copy = Faker::Lorem.paragraph.first(110)
      resource.tweets.create(copy: copy, approved: approved, sent: sent, last_approved_at: last_approved_at, last_sent_at: last_sent_at,
                             cleared: cleared, placement_id: placement_id)
    end
  end
end


