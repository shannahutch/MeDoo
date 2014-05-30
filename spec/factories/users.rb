# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    # name 'user'
    email 'user13@user.com'
    # phone '111-111-1111'
    password '123123123'
    passowrd_conformation '123123123'
  end

end
