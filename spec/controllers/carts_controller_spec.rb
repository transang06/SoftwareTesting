require "rails_helper"

RSpec.describe CartsController, type: :controller do
  let!(:room) {FactoryBot.create :room}
  let(:params) {{room_id: room.id,
                  from_time: time_current, 
                  end_time: time_current(Settings.hour_1.hour)}}

  describe "GET carts#index" do
    it "success when render template index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET carts#add" do
    context "success when valid attributes" do
      before{post :add, params: params, xhr: true}

      it "assigns @room exist" do
        expect(assigns(:room)).to eq room
      end

      it "no conflict of time" do
        expect(assigns(:time_busy).any?).to eq false
      end

      it "show flash success" do
        expect(flash[:success]).to eq I18n.t("cart.add_success")
      end
    end

    context "fail when time invalid about the distance" do
      before{post :add, params: {room_id: room.id, from_time: time_current, end_time: time_current}}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("cart.date_invalid")
      end

      it {expect(response).to redirect_to(room)}
    end

    context "fail when room doesn't exist" do
      before{post :add, params: {room_id: -1}, xhr: true}

      it "show flash warning" do
        expect(flash[:warning]).to eq I18n.t("rooms.not_exist")
      end

      it {expect(response).to redirect_to(carts_path)}
    end
    
    context "fail when time invalid" do
      before{post :add, params: {room_id: room.id, from_time: 1, end_time: 2}, xhr: true}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("cart.date_invalid")
      end

      it {expect(response).to redirect_to(room)}
    end
  end

  describe "GET carts#change" do
    context "success when valid attributes" do
      before{post :change, params: params, xhr: true}

      it "exist room in carts" do
        expect(params[:room_id]).not_to be_nil
      end

      it "no conflict of time" do
        expect(assigns(:time_busy).any?).to eq false
      end

      it {expect(response).to redirect_to(carts_path)}
    end
  end
end
