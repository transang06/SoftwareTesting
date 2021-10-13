require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  before{sign_in(user)}

  describe "GET users#show" do
    context "success when valid attributes" do
      before{get :show, params: {id: user.id}}

      it "assigns @user exist" do
        expect(assigns(:user)).to eq user
      end

      it {expect(response).to render_template(:show)}
    end

    context "fail when invalid attributes" do
      before{get :show, params: {id: -1}}
 
      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("users.nil")
      end

      it {expect(response).to redirect_to(root_path)}
    end
  end
end
