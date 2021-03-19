require 'rails_helper'

RSpec.describe CompanyReview, type: :model do
  let(:company_review) { create(:company_review) }

  describe 'バリデーション' do
    it 'rateが定義していればOK' do
      expect(company_review.valid?).to eq(true)
    end
    it 'rateが空だとNG' do
      company_review.rate = nil
      expect(company_review.valid?).to eq(false)
    end
  end
end
