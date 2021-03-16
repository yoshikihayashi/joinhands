require 'rails_helper'

RSpec.describe Project, type: :model do
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
    it 'detailsが定義していればOK' do
      expect(project.valid?).to eq(true)
    end
    it 'detailsが空だとNG' do
      project.details = nil
      expect(project.valid?).to eq(false)
    end
  end
end