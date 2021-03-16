require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { create(:company) }
   describe 'バリデーション' do
    it 'nameが定義していればOK' do
      expect(company.valid?).to eq(true)
    end
    it 'nameが空だとNG' do
      company.company_name = nil
      expect(company.valid?).to eq(false)
    end
    it 'phone_numberが定義していればOK' do
      expect(company.valid?).to eq(true)
    end
    it 'phone_numberが空だとNG' do
      company.phone_number = nil
      expect(company.valid?).to eq(false)
    end
    it 'emailが定義していればOK' do
      expect(company.valid?).to eq(true)
    end
    it 'emailが空だとNG' do
      company.email = nil
      expect(company.valid?).to eq(false)
    end
  end
end