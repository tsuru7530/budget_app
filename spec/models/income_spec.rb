require 'rails_helper'

RSpec.describe Income, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.build(:income, district_id: @district.id)
    end
    context "予算登録ができる" do
      it "年度, 地区名, 予算種別, 金額, 備考が正しく設定されていれば登録できる" do
        expect(@income).to be_valid
      end
      it "備考が空でも登録できる" do
        @income.memo = nil
        expect(@income).to be_valid
      end
    end
    context "予算登録ができない" do
      it "年度が空だと登録できない" do
        @income.year = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("年度を入力してください")
      end
      it "年度が数字以外だと登録できない" do
        @income.year = "hogehoge"
        @income.valid?
        expect(@income.errors.full_messages).to include("年度は数値で入力してください")
      end
      it "年度が6未満だと登録できない" do
        @income.year = 5
        @income.valid?
        expect(@income.errors.full_messages).to include("年度は6以上の値にしてください")
      end
      it "地区名が空だと登録できない" do
        @income.district_id = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("地区名を入力してください")
      end
      it "予算種別が空だと登録できない" do
        @income.category = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("予算種別を入力してください")
      end
      it "金額が空だと登録できない" do
        @income.price = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("金額を入力してください")
      end
      it "金額が数字以外だと登録できない" do
        @income.price = "hogehoge"
        @income.valid?
        expect(@income.errors.full_messages).to include("金額は数値で入力してください")
      end
      it "金額が0未満だと登録できない" do
        @income.price = -1
        @income.valid?
        expect(@income.errors.full_messages).to include("金額は0以上の値にしてください")
      end
      it "金額が11桁以上だと登録できない" do
        @income.price = 10000000000
        @income.valid?
        expect(@income.errors.full_messages).to include("金額は10文字以内で入力してください")
      end
      it "備考が51文字以上だと登録できない" do
        @income.memo = "a" * 51
        @income.valid?
        expect(@income.errors.full_messages).to include("備考は50文字以内で入力してください")
      end
    end
  end
end
