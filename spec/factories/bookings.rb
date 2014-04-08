# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    from "2014-04-06 21:11:20"
    till "2014-04-06 21:11:20"
    item_id 1
    user_id 1
  end
end
