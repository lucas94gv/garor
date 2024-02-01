# frozen_string_literal: true

FactoryBot.define do
  factory :user_base do
    email { Faker::Internet.email(domain: 'gmail.com') }
    user = User.new(email: Faker::Internet.email(domain: 'gmail.com'), password: Faker::Internet.password)
    encrypted_password { Devise::Encryptor.digest(User, user.password) }
    company { FactoryBot.create(:company) }
  end

  factory :user_employee, parent: :user_base do
    role { :employee }
  end

  factory :user_manager, parent: :user_base do
    role { :manager }
  end

  factory :user_admin, parent: :user_base do
    role { :admin }
  end

  factory :user_superadmin, parent: :user_base do
    role { :superadmin }
  end
end
