# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    short_desc "MyString"
    desc "MyText"
    location_id 1
    media_id 1
    type_id 1
  end
end
