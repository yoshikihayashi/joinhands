require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { create(:review) }
   describe 'バリデーション' do
    it 'rateが定義していればOK' do
      expect(review.valid?).to eq(true)
    end
    it 'rateが空だとNG' do
      review.rate = nil
      expect(review.valid?).to eq(false)
    end
  end
end