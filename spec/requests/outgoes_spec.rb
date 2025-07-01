require 'rails_helper'

RSpec.describe "Outgoes", type: :request do
  describe "#new" do
    context "予算執行の新規作成ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get new_income_outgo_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名(年度, 金額, 備考)が正しく表示されている" do
        expect(response.body).to include("年度")
        expect(response.body).to include("金額")
        expect(response.body).to include("備考")
      end
    end
  end
  describe "#edit" do
    context "予算執行の編集ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        @outgo = FactoryBot.create(:outgo, income_id: @income.id)
        get edit_income_outgo_path(@income,@outgo)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名(年度, 金額, 備考)が正しく表示されている" do
        expect(response.body).to include("年度")
        expect(response.body).to include("金額")
        expect(response.body).to include("備考")
      end
      it "予算執行の年度, 金額, 備考が正しく表示されている" do
        expect(response.body).to include(@outgo.year)
        expect(response.body).to include(@outgo.price.to_s)
        expect(response.body).to include(@outgo.memo)
      end
    end
  end
end
