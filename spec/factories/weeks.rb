# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :week do
    weekly_goal_name "MyString"
    goal_id 1
    week_num 1
    year 1
    month 1
  end
end
