require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let!(:room) {FactoryBot.create :room}
  let!(:furniture) {FactoryBot.create(:furniture, room_id: room.id)}
  let!(:user) {FactoryBot.create :user}
  let!(:receipt) {FactoryBot.create :receipt, user_id: user.id}
  let!(:receipts) {user.receipts}

  describe "GET rooms#show" do
    context "success when room do exist" do
      before{get :show, params: {id: room}}

      it "assigns @room" do
        expect(assigns(:room)).to eq room
      end

      it "assigns @time_busy" do
        expect(assigns(:time_busy)).to eq room.receipts.status_approved.select(:from_time, :end_time)
      end
  
      it "assigns @furnitures for room" do
        expect(assigns(:furnitures)).to eq room.furnitures
      end
    end

    context "fail when room doesn't exist" do
      before{get :show, params: {id: -1}}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("rooms.not_exist")
      end

      it {expect(response).to redirect_to(root_path)}
    end
  end

  describe "GET rooms#search" do
    context "success when room do exist" do
      let(:params) {{key: "", from_time: receipt.from_time, 
                     end_time: receipt.end_time, min: 0, max: nil}}
      before{get :search, params: params}

      it "assigns @room_ids_busy exist" do
        expect(assigns(:room_ids_busy).class.to_s).to eq "Receipt::ActiveRecord_Relation"
      end

      it "assigns @rooms exist" do
        result = Room.name_has(params[:key])
                      .price_greater(params[:min])
                      .price_less(params[:max])
                      .not_in(assigns(:room_ids_busy))
        expect(assigns(:rooms)) == result
      end
    end
  end
end
