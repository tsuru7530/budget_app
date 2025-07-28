require 'rails_helper'

RSpec.describe District, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.build(:district)
    end
    context "地区登録ができる" do
      it "地区名, 年度, 事務所名, 画像, 緯度, 経度が正しく設定されていれば登録できる" do
        expect(@district).to be_valid
      end
      it "画像が空でも登録できる" do
        @district.image = nil
        expect(@district).to be_valid
      end
    end
    context "地区登録ができない" do
      it "地区名が空だと登録できない" do
        @district.name = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("地区名を入力してください")
      end
      it "地区名が51文字以上だと登録できない" do
        @district.name = "a" * 51
        @district.valid?
        expect(@district.errors.full_messages).to include("地区名は50文字以内で入力してください")
      end
      it "年度が空だと登録できない" do
        @district.year = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("年度を入力してください")
      end
      it "年度が数字以外だと登録できない" do
        @district.year = "hogehoge"
        @district.valid?
        expect(@district.errors.full_messages).to include("年度は数値で入力してください")
      end
      it "年度が7未満だと登録できない" do
        @district.year = 6
        @district.valid?
        expect(@district.errors.full_messages).to include("年度は7以上の値にしてください")
      end
      it "事務所名が空だと登録できない" do
        @district.office = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("事務所名を入力してください")
      end
      it "事務所名が51文字以上だと登録できない" do
        @district.office = "a" * 51
        @district.valid?
        expect(@district.errors.full_messages).to include("事務所名は50文字以内で入力してください")
      end
      it "緯度が空だと登録できない" do
        @district.latitude = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("緯度を入力してください")
      end
      it "経度が空だと登録できない" do
        @district.longitude = nil
        @district.valid?
        expect(@district.errors.full_messages).to include("経度を入力してください")
      end
    end
  end
end
