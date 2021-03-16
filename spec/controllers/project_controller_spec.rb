require 'rails_helper'

RSpec.describe Project, type: :controller do
  
  describe 'GET #edit' do
    it "assigns the requested post to @post" do
      post = create(:post)
      get :edit, params: { id: post }
      expect(assigns(:post)).to eq post
    end

    it "renders the :edit template" do
      post = create(:post)
      get :edit, params: { id: post }
      expect(response).to render_template :edit
    end
  end
end