puts 'Start inserting seed "comments" ...'
Post.all.each do |post|
  comment = post.comments.create(
    {
       body: Faker::Hacker.say_something_smart,
       user_id: User.all.sample.id
    }
  )
  puts "comment#{comment.id} has created!"
end