require 'rails_helper'

RSpec.describe Outgo, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.build(:outgo, income_id: @income.id)
    end
    context "予算執行登録ができる" do
      it "年度, 予算, 金額, 備考が正しく設定されていれば登録できる" do
        expect(@outgo).to be_valid
      end
    end
    context "予算執行登録ができない" do
      it "年度が空だと登録できない" do
        @outgo.year = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("年度を入力してください")
      end
      it "年度が数字以外だと登録できない" do
        @outgo.year = "hogehoge"
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("年度は数値で入力してください")
      end
      it "年度が7未満だと登録できない" do
        @outgo.year = 6
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("年度は7以上の値にしてください")
      end
      it "金額が空だと登録できない" do
        @outgo.price = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("金額を入力してください")
      end
      it "金額が数字以外だと登録できない" do
        @outgo.price = "hogehoge"
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("金額は数値で入力してください")
      end
      it "金額が0未満だと登録できない" do
        @outgo.price = -1
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("金額は0以上の値にしてください")
      end
      it "金額が11桁以上だと登録できない" do
        @income.price = 10000000000
        @income.valid?
        expect(@income.errors.full_messages).to include("金額は10文字以内で入力してください")
      end
      it "備考が空だと登録できない" do
        @outgo.memo = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("備考を入力してください")
      end
      it "備考が51文字以上だと登録できない" do
        @income.memo = "a" * 51
        @income.valid?
        expect(@income.errors.full_messages).to include("備考は50文字以内で入力してください")
      end
    end
  end
end
