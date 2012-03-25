# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |u|  
  u.sequence(:login) { |n| "user#{n}" }
  u.name "User Superuser"
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.password "johnsilver"
  u.password_confirmation "johnsilver"  
end

Factory.define :project do |p|  
  p.sequence(:title) { |n| "Project#{n}" }  
end


Factory.define :record do |r|  
  r.association :user
  r.association :project
  r.activity_id Activity.first.id
  r.date Date.today
  r.time '01:01'
end

