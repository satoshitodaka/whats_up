# puts 'Start inserting seed "posts"...'
# User.limit(3).each do |user|
#   post = user.posts.create(
#     # body: Faker::Hacker.say_something_smart
#     body: 'hogehoge'
#   )
#   puts "post-#{post.id} has created."
# end

puts 'Start inserting seed "posts" ...'
User.limit(10).each do |user|
  post = user.posts.create({ body: Faker::Hacker.say_something_smart})
  puts "post#{post.id} has created!"
end