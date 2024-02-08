# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: 'gmail.com') }
    user = User.new(email: Faker::Internet.email(domain: 'gmail.com'), password: Faker::Internet.password)
    password { Devise::Encryptor.digest(User, user.password) }
    company { FactoryBot.create(:company) }
  end

  factory :employee, parent: :user do
    role { :employee }
  end

  factory :manager, parent: :user do
    role { :manager }
  end

  factory :admin, parent: :user do
    role { :admin }
  end

  factory :superadmin, parent: :user do
    role { :superadmin }
  end
end
