FactoryGirl.define do
  factory :todo do
    title {Faker::Hobby.activity}
    due_date {"2024-10-10"}
    user_id {1}

    trait :skip_user_id_validation do
      due_date {"2024"}
      to_create { |instance| instance.save(validate: false) }
    end
    
  end
end