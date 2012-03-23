namespace :db do
  desc "Fill database with initial data"
  task :populate => :environment do
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
       
  end
end
