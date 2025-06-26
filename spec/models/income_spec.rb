require 'rails_helper'

RSpec.describe Income, type: :model do
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.build(:income, district_id: @district.id)
    end
    context "予算登録ができる" do
      it "year, district_id,  cagegory, price, memoが正しく設定されていれば登録できる" do
        expect(@income).to be_valid
      end
      it "memoが空でも登録できる" do
        @income.memo = nil
        expect(@income).to be_valid
      end
    end
    context "予算登録ができない" do
      it "yearが空だと登録できない" do
        @income.year = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("Year can't be blank")
      end
      it "yearが数字以外だと登録できない" do
        @income.year = "hogehoge"
        @income.valid?
        expect(@income.errors.full_messages).to include("Year is not a number")
      end
      it "yearが6未満だと登録できない" do
        @income.year = 5
        @income.valid?
        expect(@income.errors.full_messages).to include("Year must be greater than or equal to 6")
      end
      it "districtが空だと登録できない" do
        @income.district_id = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("District can't be blank")
      end
      it "categoryが空だと登録できない" do
        @income.category = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("Category can't be blank")
      end
      it "priceが空だと登録できない" do
        @income.price = nil
        @income.valid?
        expect(@income.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが数字以外だと登録できない" do
        @income.price = "hogehoge"
        @income.valid?
        expect(@income.errors.full_messages).to include("Price is not a number")
      end
      it "priceが0未満だと登録できない" do
        @income.price = -1
        @income.valid?
        expect(@income.errors.full_messages).to include("Price must be greater than or equal to 0")
      end
      it "priceが11桁以上だと登録できない" do
        @income.price = 10000000000
        @income.valid?
        expect(@income.errors.full_messages).to include("Price is too long (maximum is 10 characters)")
      end
      it "memoが51文字以上だと登録できない" do
        @income.memo = "a" * 51
        @income.valid?
        expect(@income.errors.full_messages).to include("Memo is too long (maximum is 50 characters)")
      end
    end
  end
end
