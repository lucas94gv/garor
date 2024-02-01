# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @employee = FactoryBot.create(:user_employee)
    @manager = FactoryBot.create(:user_manager)
    @admin = FactoryBot.create(:user_admin)
    @superadmin = FactoryBot.create(:user_superadmin)
  end

  describe 'Factory' do
    it 'is valid with a correct factory' do
      expect(@employee).to be_valid
      expect(@manager).to be_valid
      expect(@admin).to be_valid
      expect(@superadmin).to be_valid
    end
  end

  describe 'Validations' do
    it 'is valid if email is string' do
      expect(@employee.email).to(be_kind_of(String))
    end

    it 'is not valid if email isnt integer' do
      expect(@employee.email).not_to(be_kind_of(Integer))
    end

    it 'is not valid if email is not presnet' do
      @employee.email = nil
      expect(@employee).not_to(be_valid)
    end

    it 'is valid if encrypted_password is string' do
      expect(@employee.encrypted_password).to(be_kind_of(String))
    end

    it 'is not valid if encrypted_password isnt integer' do
      expect(@employee.encrypted_password).not_to(be_kind_of(Integer))
    end

    it 'is not valid if encrypted_password is not present' do
      @employee.encrypted_password = nil
      expect(@employee).not_to(be_valid)
    end
    
    it 'is valid if company_id is string' do
      expect(@employee.company_id).to(be_kind_of(String))
    end

    it 'is not valid if company_id isnt integer' do
      expect(@employee.company_id).not_to(be_kind_of(Integer))
    end

    it 'is not valid if company_id is not present' do
      @employee.company_id = nil
      expect(@employee).not_to(be_valid)
    end 

    it 'is valid value' do
      @employee.email = ''
      expect(@employee).not_to(be_valid)
    end

    it 'is not valid with a duplicate email' do
      new_employee = FactoryBot.create(:user_employee)
      @employee.email = new_employee.email
      expect(@employee).to_not(be_valid)
    end

    it 'is valid when company_id is a Company' do
      expect(@employee.company).to(be_kind_of(Company))
    end

    it 'is not valid when company_id is not a Company' do
      expect(@employee.company).to(be_kind_of(User))
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:company) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:role).with_values(%i[employee manager admin superadmin]).with_suffix(:enum) }
    it { is_expected.not_to define_enum_for(:role).with_values(%i[invalid_role]).with_suffix(:enum) }
  end
end
