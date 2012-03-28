namespace :db do
  namespace :test do
   desc "Fill database with initial data"
    task :populate => :environment do
     Rake::Task['db:test:prepare'].invoke

      initial_data

    end
  end
end


def initial_data

  ('Self development,Working time,Extra time,Team time').split(',').each do |a|
    Activity.create :activity => a
  end
  
  Project.create :title => "NA"

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

