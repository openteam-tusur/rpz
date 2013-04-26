User.find_or_initialize_by_email('mail@openteam.ru').tap do |user|
  user.save(validate: false)
  user.permissions << Permission.new(role: :manager)
end
