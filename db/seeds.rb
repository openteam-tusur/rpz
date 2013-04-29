User.find_or_initialize_by_email('mail@openteam.ru').tap do |user|
  user.save(validate: false)
  user.permissions << Permission.new(role: :manager)
end

Year.find_or_initialize_by_title('2013 - 2014 учебный год').tap do |year|
  year.autumn_semester_attributes = { starts_on: '2013-09-02', breaks_on: '2013-10-21', ends_on: '2013-12-23' }
  year.spring_semester_attributes = { starts_on: '2014-02-17', breaks_on: '2014-04-21', ends_on: '2014-06-14' }
  year.save!
end
