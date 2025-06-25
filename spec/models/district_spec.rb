require 'rails_helper'

RSpec.describe District, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.build(:district)
    end

    context "地区登録ができる" do
      it "name, year, office, imageが正しく設定されていれば登録できる" do
        expect(@district).to be_valid
      end
    end

    context "地区登録ができない" do
      it "nameが空だと登録できない" do
        @district.name = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("Name can't be blank")
      end
      it "yearが空だと登録できない" do
        @district.year = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("Year can't be blank")
      end
      it "yearが数字以外だと登録できない" do
        @district.year = "hogehoge"
        @district.valid?
        expect(@district.errors.full_messages).to include("Year is not a number")
      end
    end
  end
end
