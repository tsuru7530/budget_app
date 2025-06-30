require 'rails_helper'

RSpec.describe "Outgoes", type: :request do
  describe "#new" do
    context "outgoの新規作成ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get new_income_outgo_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名(year, price, memo)が正しく表示されている" do
        expect(response.body).to include("year")
        expect(response.body).to include("price")
        expect(response.body).to include("memo")
      end
    end
  end
  describe "#edit" do
    context "outgoの編集ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        @outgo = FactoryBot.create(:outgo, income_id: @income.id)
        get edit_income_outgo_path(@income,@outgo)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名(year, price, memo)が正しく表示されている" do
        expect(response.body).to include("year")
        expect(response.body).to include("price")
        expect(response.body).to include("memo")
      end
      it "outgoのyear, price, memoが正しく表示されている" do
        expect(response.body).to include(@outgo.year)
        expect(response.body).to include(@outgo.price.to_s)
        expect(response.body).to include(@outgo.memo)
      end
    end
  end
end
