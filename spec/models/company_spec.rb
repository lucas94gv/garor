# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Company, type: :model) do
  before(:each) do
    @company = FactoryBot.create(:company)
  end

  describe 'database kind fields' do
    it 'cif is string' do
      expect(@company.cif).to(be_kind_of(String))
    end

    it 'cif isnt integer' do
      expect(@company.cif).not_to(be_kind_of(Integer))
    end

    it 'presence of cif' do
      @company.cif = nil
      expect(@company).not_to(be_valid)
    end

    it 'valid value' do
      @company.cif = ''
      expect(@company).not_to(be_valid)
    end

    it 'is valid with valid attributes' do
      expect(@company).to(be_valid)
    end
  end

  describe 'data validity' do
    it 'is not valid with a duplicate cif' do
      new_company = FactoryBot.create(:company)
      @company.cif = new_company.cif
      expect(@company).to_not(be_valid)
    end

    it 'is not valid with a cif shorter than 11 characters' do
      @company.cif = '1234567'
      expect(@company).to_not be_valid
    end

    it 'is not valid with a cif longer than 11 characters' do
      @company.cif = '123456789012345'
      expect(@company).to_not be_valid
    end
  end
end