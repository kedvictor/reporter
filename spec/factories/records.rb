# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    user_id ""
    project_id ""
    activity_id 1
    date "2012-03-18"
    time "2012-03-18 06:53:28"
    description "MyText"
  end
end
