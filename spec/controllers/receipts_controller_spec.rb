require "rails_helper"
require 'shared_contexts'

RSpec.describe ReceiptsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:receipt) {FactoryBot.create :receipt, user_id: user.id}
  let!(:receipts) {user.receipts}

  include_examples "login example"
  before{sign_in(user)}
  
  describe "GET receipts#index" do
    context "success when valid attributes" do
      before{get :index}

      it "assigns @receipts" do
        expect(assigns(:receipts)).to eq receipts
      end

      it {expect(response).to render_template(:index)}
    end
  end

  describe "GET receipts#show" do   
    context "success when valid attributes" do
      before{get :show, params:{id: receipt.id}}

      it "assigns @receipt exist" do
        expect(assigns(:receipt)).to eq receipt
      end

      it {expect(response).to render_template(:show)}
    end

    context "fail when receipt not exist" do
      before{get :show, params: {id: -1}}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("receipt.not_permissions")
      end

      it {expect(response).to redirect_to(receipts_path)}
    end
  end

  describe "POST receipts#cancel_booking" do
    context "success when valid attributes" do
      before{post :cancel_booking, params:{id: receipt.id}}

      it "assigns @receipt exist" do
        expect(assigns(:receipt)).to eq receipt
      end
      
      it "status receipt is cancelled by you " do
        expect(assigns(:receipt).cancelled_by_you?).to be true
      end

      it {expect(response).to redirect_to(receipt)}
    end 

    context "fail when receipt is not found" do
      before{post :cancel_booking, params:{id: -1}}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("receipt.not_exist")
      end

      it {expect(response).to redirect_to(receipts_path)}
    end 

    context "fail when status receipt is not wait" do
      before do
        receipt.update_column :status, 1
        post :cancel_booking, params:{id: receipt.id}
      end

      it "assigns @receipt exist" do
        expect(assigns(:receipt)).to eq receipt
      end
      
      it "show flash danger" do
        expect(flash[:warning]).to eq I18n.t("receipt.invalid_status")
      end

      it {expect(response).to redirect_to(receipt)}
    end
  end
end
