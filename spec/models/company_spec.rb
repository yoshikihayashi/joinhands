require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'バリデーション' do
    subject { company.valid? }

    let!(:other_company) { create(:company) }
    let(:company) { build(:company) }

    it 'company_nameが定義していればOK' do
      expect(company.valid?).to eq(true)
    end
    it 'company_nameが空だとNG' do
      company.company_name = nil
      expect(company.valid?).to eq(false)
    end
    it 'company_nameが2文字以上であること: 1文字は×' do
      company.company_name = Faker::Lorem.characters(number: 1)
      is_expected.to eq false
    end
    it '50文字以下であること: 51文字は×' do
      company.company_name = Faker::Lorem.characters(number: 51)
      is_expected.to eq false
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

  describe 'アソシエーションのテスト' do
    context 'Projectモデルとの関係' do
      it '1:Nとなっている' do
        expect(Company.reflect_on_association(:projects).macro).to eq :has_many
      end
    end
  end
end
