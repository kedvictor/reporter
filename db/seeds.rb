
('Self development,Working time,Extra time,Team time').split(',').each do |a|
    Activity.create :activity => a
end

('NA,Dolphin,Spree,Blue Print,Calgary Beach').split(',').each do |p|
    Project.create :title => p
end

 User.create(
    :login => 'newcomer',
    :name => 'newcomer',
    :email => 'newcomer@example.com',
    :position => 'newcomer',
    :password => 'neofit',
    :password_confirmation => 'neofit'
    )

  User.create(
    :login => 'user',
    :name => 'Super User',
    :email => 'user@example.com',
    :position => '',
    :password => 'superuser',
    :password_confirmation => 'superuser'
    )


    puts
    puts "=============== Credentials ================================="
    puts
    puts "For newcomer     login: newcomer, password: neofit"
    puts "For user         login: user, password: superuser"
    puts
    puts "============================================================="
    puts

  @activities = Activity.all
  @projects = Project.all
  @user = User.find_by_login "user"

  (Date.today - 20.day).upto(Date.today) do |date|
    @activities.each do |activity|
      rand(0..3).times do
        Record.create!(
          :activity_id => activity.id,
          :project_id => @projects.shuffle.first.id,
          :user_id => @user.id,
          :date => date,
          :time => "#{rand(0..4)}:#{rand(0..59)}",
          :description => 'description'
        )
     end
    end
  end

