require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { project.valid? }

  let(:project) { create(:project) }

  describe 'バリデーション' do
    it 'priceが定義していればOK' do
      expect(project.valid?).to eq(true)
    end
    it 'priceが空だとNG' do
      project.price = nil
      expect(project.valid?).to eq(false)
    end
    it 'titleが定義していればOK' do
      expect(project.valid?).to eq(true)
    end
    it 'titleが空だとNG' do
      project.title = nil
      expect(project.valid?).to eq(false)
    end
    it 'titleが75文字以下であること: 75文字OK' do
      project.title = Faker::Lorem.characters(number: 75)
      is_expected.to eq true
    end
    it 'titleが75文字以下であること: 76文字NG' do
      project.title = Faker::Lorem.characters(number: 76)
      is_expected.to eq false
    end
    it 'detailsが定義していればOK' do
      expect(project.valid?).to eq(true)
    end
    it 'detailsが空だとNG' do
      project.details = nil
      expect(project.valid?).to eq(false)
    end
    it 'detailsが350文字以下であること: 350文字OK' do
      project.details = Faker::Lorem.characters(number: 350)
      is_expected.to eq true
    end
    it 'detailsが350文字以下であること: 351文字NG' do
      project.details = Faker::Lorem.characters(number: 351)
      is_expected.to eq false
    end
  end
end
