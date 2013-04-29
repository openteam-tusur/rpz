User.find_or_initialize_by_email('mail@openteam.ru').tap do |user|
  user.save(validate: false)
  user.permissions << Permission.new(role: :manager)
end

Year.find_or_initialize_by_title('2013 - 2014 учебный год').tap do |year|
  year.autumn_semester_attributes = { starts_on: '2012-09-03', breaks_on: '2012-11-05', ends_on: '2012-12-31' }
  year.spring_semester_attributes = { starts_on: '2013-02-11', breaks_on: '2013-04-08', ends_on: '2013-05-27' }
  year.save!
end
