require 'rails_helper'

RSpec.describe Outgo, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.build(:outgo, income_id: @income.id)
    end
    context "予算執行登録ができる" do
      it "year, income_id, price, memoが正しく設定されていれば登録できる" do
        expect(@outgo).to be_valid
      end
    end
    context "予算執行登録ができない" do
      it "yearが空だと登録できない" do
        @outgo.year = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Year can't be blank")
      end
      it "yearが数字以外だと登録できない" do
        @outgo.year = "hogehoge"
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Year is not a number")
      end
      it "yearが7未満だと登録できない" do
        @outgo.year = 6
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Year must be greater than or equal to 7")
      end
      it "priceが空だと登録できない" do
        @outgo.price = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが数字以外だと登録できない" do
        @outgo.price = "hogehoge"
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Price is not a number")
      end
      it "priceが0未満だと登録できない" do
        @outgo.price = -1
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Price must be greater than or equal to 0")
      end
      it "priceが11桁以上だと登録できない" do
        @income.price = 10000000000
        @income.valid?
        expect(@income.errors.full_messages).to include("Price is too long (maximum is 10 characters)")
      end
      it "memoが空だと登録できない" do
        @outgo.memo = nil
        @outgo.valid?
        expect(@outgo.errors.full_messages).to include("Memo can't be blank")
      end
      it "memoが51文字以上だと登録できない" do
        @income.memo = "a" * 51
        @income.valid?
        expect(@income.errors.full_messages).to include("Memo is too long (maximum is 50 characters)")
      end
    end
  end
end
