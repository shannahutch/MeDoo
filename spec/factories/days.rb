# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day do
    day_task_name "MyString"
    year 1
    month 1
    week_num 1
    day 1
    goal nil
  end
end
