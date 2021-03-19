require 'rails_helper'

RSpec.describe Influencer, type: :model do
  let(:influencer) { create(:influencer) }

  describe 'バリデーション' do
    it 'nameが定義していればOK' do
      expect(influencer.valid?).to eq(true)
    end
    it 'nameが空だとNG' do
      influencer.name = nil
      expect(influencer.valid?).to eq(false)
    end
    it 'phone_numberが定義していればOK' do
      expect(influencer.valid?).to eq(true)
    end
    it 'phone_numberが空だとNG' do
      influencer.phone_number = nil
      expect(influencer.valid?).to eq(false)
    end
    it 'emailが定義していればOK' do
      expect(influencer.valid?).to eq(true)
    end
    it 'emailが空だとNG' do
      influencer.email = nil
      expect(influencer.valid?).to eq(false)
    end
  end
end
