FactoryGirl.define do
  factory :page do
    sequence(:title) { |n| "test_title_#{n}" }
    content "content text"
  end
end
