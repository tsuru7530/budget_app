require 'rails_helper'

RSpec.describe "Incomes", type: :request do
  describe "#index" do
    context "予算の一覧ページが正しく表示される(予算未登録の場合)" do
      before do
        @district = FactoryBot.create(:district)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "地区の地区名, 年度, 事務所名が表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
      it '表題(年度, 予算種別, 備考)が表示されていない'  do
        expect(response.body).to_not include("年度")
        expect(response.body).to_not include("予算種別")
        expect(response.body).to_not include("備考")
      end
    end
    context "予算の一覧ページが正しく表示される(予算登録済みの場合)" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "地区の地区名, 年度, 事務所名が表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
      it '表題(年度, 予算種別, 備考)が表示されている'  do
        expect(response.body).to include("年度")
        expect(response.body).to include("予算種別")
        expect(response.body).to include("備考")
      end
      it "予算の年度, 予算種別, 備考が表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.memo)
      end
    end
  end
  describe "#show" do
    context "予算の詳細ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        @outgo = FactoryBot.create(:outgo, income_id: @income.id)
        get income_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it '表題(年度, 予算種別, 金額, 備考)が表示されている'  do
        expect(response.body).to include("年度")
        expect(response.body).to include("予算種別")
        expect(response.body).to include("金額")
        expect(response.body).to include("備考")
      end
      it "予算の年度, 予算種別, 金額, 備考が表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.price.to_fs(:delimited))
        expect(response.body).to include(@income.memo)
      end
      it "執行の年度, 金額, 備考が表示されている" do
        expect(response.body).to include(@outgo.year)
        expect(response.body).to include(@outgo.price.to_fs(:delimited))
        expect(response.body).to include(@outgo.memo)
      end
    end
  end
  describe "#new" do
    context "予算の新規作成ページが正しく表示される" do
      before do 
        get new_income_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名が正しく表示されている" do
        expect(response.body).to include("地区名")
        expect(response.body).to include("年度")
        expect(response.body).to include("予算種別")
        expect(response.body).to include("金額")
        expect(response.body).to include("備考")
      end
    end
  end
  describe "#edit" do
    context "予算の編集ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        @income = FactoryBot.create(:income, district_id: @district.id)
        get edit_income_path(@income)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名が正しく表示されている" do
        expect(response.body).to include("地区名")
        expect(response.body).to include("年度")
        expect(response.body).to include("予算種別")
        expect(response.body).to include("金額")
        expect(response.body).to include("備考")
      end
      it "予算の年度, 予算種別, 金額, 備考が正しく表示されている" do
        expect(response.body).to include(@income.year)
        expect(response.body).to include(@income.category)
        expect(response.body).to include(@income.price.to_s)
        expect(response.body).to include(@income.memo)
      end
    end
  end
end
