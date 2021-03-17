require 'rails_helper'

RSpec.describe InfluencerProject, type: :model do
  subject { influencer_project.valid? }
  let(:influencer_project) { create(:influencer_project) }
   describe 'バリデーション' do
    it 'messageが定義していればOK' do
      expect(influencer_project.valid?).to eq(true)
    end
    it 'messageが空だとNG' do
      influencer_project.message = nil
      expect(influencer_project.valid?).to eq(false)
    end
    it 'messageが300文字以下であること: 300文字OK' do
      influencer_project.message = Faker::Lorem.characters(number: 300)
      is_expected.to eq true
    end
    it 'messageが300文字以下であること: 301文字NG' do
      influencer_project.message = Faker::Lorem.characters(number: 301)
      is_expected.to eq false
    end
    it 'influencer_messageが定義していればOK' do
      expect(influencer_project.valid?).to eq(true)
    end
    it 'influencer_messageが空だとNG' do
      influencer_project.influencer_message = nil
      expect(influencer_project.valid?).to eq(false)
    end
    it 'influencer_messageが300文字以下であること: 300文字OK' do
      influencer_project.influencer_message = Faker::Lorem.characters(number: 300)
      is_expected.to eq true
    end
    it 'influencer_messageが300文字以下であること: 301文字NG' do
      influencer_project.influencer_message = Faker::Lorem.characters(number: 301)
      is_expected.to eq false
    end
  end
end