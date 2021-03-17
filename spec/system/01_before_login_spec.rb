require 'rails_helper'

describe '[STEP1] ログイン前のテスト' do
  describe 'influencer_info画面のテスト' do
    before do
      visit '/homes/influencer_info'
    end

    context '表示内容の確認' do
      it 'コンテンツが正しい' do
        expect(page.body).to have_text'空いた時間にSNSで仕事ができる！'
      end
    end
  end
end