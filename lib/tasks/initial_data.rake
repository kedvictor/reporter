namespace :db do
  desc "Fill database with initial data"
  task :populate => :environment do
    Rake::Task['db:migrate'].invoke

    Activity.create :activity => 'Self development'
    Activity.create :activity => 'Working time'
    Activity.create :activity => 'Extra time'
    Activity.create :activity => 'Team time'

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

    Rake::Task['db:test:prepare'].invoke

    Activity.create :activity => 'Self development'
    Activity.create :activity => 'Working time'
    Activity.create :activity => 'Extra time'
    Activity.create :activity => 'Team time'

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

  end
end

