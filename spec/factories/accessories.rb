# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accessory do
    key "MyString"
    value "MyText"
    item_id 1
  end
end
