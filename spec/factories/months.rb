# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :month do
    month_goal_name "MyString"
    goal_id 1
    month_num 1
    year 1
  end
end
