require 'faker'

FactoryGirl.define do
  factory :user do
    pwd = Faker::Internet.password

    name { Faker::Name.name }
    email { Faker::Internet.email }
    password pwd 
    password_confirmation pwd

    factory :admin do
      admin true
    end

    # factory :user_with_uploads do
    #   ignore do
    #     uploads_count 5
    #   end

    #   after(:create) do |user, evaluator|
    #     create_list(:mp3_upload, evaluator.uploads_count, user: user)
    #   end
    # end
  end
end
