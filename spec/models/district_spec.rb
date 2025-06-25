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
      it "imageが空だと登録できない" do
        @district.image = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空だと登録できない" do
        @district.name = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("Name can't be blank")
      end
      it "nameが51文字以上だと登録できない" do
        @district.name = "a" * 51
        @district.valid?
        expect(@district.errors.full_messages).to include("Name is too long (maximum is 50 characters)")
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
      it "yearが7未満だと登録できない" do
        @district.year = 6
        @district.valid?
        expect(@district.errors.full_messages).to include("Year must be greater than or equal to 7")
      end
      it "officeが空だと登録できない" do
        @district.office = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("Office can't be blank")
      end
      it "officeが51文字以上だと登録できない" do
        @district.office = "a" * 51
        @district.valid?
        expect(@district.errors.full_messages).to include("Office is too long (maximum is 50 characters)")
      end
    end
  end
end
