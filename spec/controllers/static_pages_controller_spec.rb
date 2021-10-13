require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET static_pages#home" do
    let!(:room) {FactoryBot.create :room}
    let!(:rooms) {Room.latest}

    it "success when render template home" do
      get :home
      expect(assigns(:rooms)) == rooms
      expect(response).to render_template :home
    end
  end

  describe "GET static_pages#contact" do
    it "success when render template contact" do
      get :contact
      expect(response).to render_template :contact
    end
  end

  describe "GET static_pages#about" do
    it "success when render template about" do
      get :about
      expect(response).to render_template :about
    end
  end

  describe "GET static_pages#help" do
    it "success when render template help" do
      get :help
      expect(response).to render_template :help
    end
  end
end
