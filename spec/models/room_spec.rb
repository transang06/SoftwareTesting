require "spec_helper"

RSpec.describe Room, type: :model do
  let!(:room_1) {FactoryBot.create(:room)}
  let!(:room_2) {FactoryBot.create(:room, name: "zzZz")}
  let!(:furniture) {FactoryBot.create(:furniture, room_id: room_1.id)}

  describe "validates" do
    it "name is presence" do
      record = Room.new(name: "")
      record.validate 
      expect(record.errors[:name]).to include("can't be blank") 
    end

    it "name is presence" do
      record = Room.new(type_room: "")
      record.validate 
      expect(record.errors[:type_room]).to include("can't be blank") 
    end
  end

  describe "callbacks" do
    it "name capitalize" do
      expect(room_2.name).to eq "Zzzz"
    end
  end

  describe "associations" do
    it "has_many furnitures" do
      t = Room.reflect_on_association(:furnitures)
      expect(t.macro).to eq(:has_many)
    end
    it "has_many receipts" do
      t = Room.reflect_on_association(:receipts)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe "scope" do
    it "sort desc room by name" do
      expect(Room.latest).to eq ([room_2, room_1])
    end

    it "load room with price greater than or equal to x" do
      expect(Room.price_greater(room_1.hourly_price)).to eq([room_1, room_2])
    end

    it "load room with price less than or equal to x" do
      expect(Room.price_less(room_1.hourly_price)).to eq([room_1, room_2])
    end

    it "load room with name has keywords" do
      expect(Room.name_has(room_1.name)).to eq([room_1])
    end

    it "load room with id not in [x]" do
      expect(Room.not_in(room_1.id)).to eq([room_2])
    end
  end
end
