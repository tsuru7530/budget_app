require 'rails_helper'

RSpec.describe "Incomes", type: :request do
  describe "#index" do
    context "incomeの一覧ページが正しく表示される(income未登録の場合)" do
      before do
        @district = FactoryBot.create(:district)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "districtのname, year, officeが表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
      it '表題(year, category, memo)が表示されていない'  do
        expect(response.body).to_not include("year")
        expect(response.body).to_not include("category")
        expect(response.body).to_not include("memo")
      end
    end
    context "incomeの一覧ページが正しく表示される(income登録済みの場合)" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "districtのname, year, officeが表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
      it '表題(year, category, memo)が表示されている'  do
        expect(response.body).to include("year")
        expect(response.body).to include("category")
        expect(response.body).to include("memo")
      end
      it "incomeのyear, category, memoが表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.memo)
      end
    end
  end
  describe "#show" do
    context "incomeの詳細ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        @outgo = FactoryBot.create(:outgo, income_id: @income.id)
        get income_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it '表題(year, category, price, memo)が表示されている'  do
        expect(response.body).to include("year")
        expect(response.body).to include("category")
        expect(response.body).to include("price")
        expect(response.body).to include("memo")
      end
      it "incomeのyear, category, price, memoが表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.price.to_s)
        expect(response.body).to include(@income.memo)
      end
      it "outgoのyear, price, memoが表示されている" do
        expect(response.body).to include(@outgo.year)
        expect(response.body).to include(@outgo.price.to_s)
        expect(response.body).to include(@outgo.memo)
      end
    end
  end
  describe "#new" do
    context "incomeの新規作成ページが正しく表示される" do
      before do 
        get new_income_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名が正しく表示されている" do
        expect(response.body).to include("district")
        expect(response.body).to include("year")
        expect(response.body).to include("category")
        expect(response.body).to include("price")
        expect(response.body).to include("memo")
      end
    end
  end
  describe "#edit" do
    context "incomeの編集ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get edit_income_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名が正しく表示されている" do
        expect(response.body).to include("district")
        expect(response.body).to include("year")
        expect(response.body).to include("category")
        expect(response.body).to include("price")
        expect(response.body).to include("memo")
      end
      it "incomeのyear, category, price, memoが正しく表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.price.to_s)
        expect(response.body).to include(@income.memo)
      end
    end
  end
end
