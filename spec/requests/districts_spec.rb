require 'rails_helper'

RSpec.describe "Districts", type: :request do
  describe "#index" do
    context "地区一覧ページが正しく表示される(地区未登録の場合)" do
      before do
        get districts_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "ページタイトルが表示されている" do
        expect(response.body).to include("地区一覧")
      end
      it '表題(地区名, 年度, 事務所名)が表示されていない'  do
        expect(response.body).to_not include("地区名")
        expect(response.body).to_not include("年度")
        expect(response.body).to_not include("事務所名")
      end
    end
    context "地区一覧ページが正しく表示される(地区登録済みの場合)" do
      before do
        @district = FactoryBot.create(:district)
        get districts_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it '表題(地区名, 年度, 事務所名)が表示されている'  do
        expect(response.body).to include("地区名")
        expect(response.body).to include("年度")
        expect(response.body).to include("事務所名")
      end
      it '作成した地区の地区名, 年度, 事務所名が正しく表示されている'  do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
  describe "#new" do
    context "地区の新規作成ページが正しく表示される" do
      before do
        get new_district_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名が正しく表示されている" do
        expect(response.body).to include("地区名")
        expect(response.body).to include("年度")
        expect(response.body).to include("事務所名")
        expect(response.body).to include("画像")
      end
    end
  end
  describe "#show" do
    context "地区の詳細ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "作成した地区の地区名, 年度, 事務所名が正しく表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
  describe "#edit" do
    context "地区の編集ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        get edit_district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "入力フォームの各項目名(地区名, 年度, 事務所名, 画像)が正しく表示されている" do
        expect(response.body).to include("地区名")
        expect(response.body).to include("年度")
        expect(response.body).to include("事務所名")
        expect(response.body).to include("画像")
      end
      it "作成した地区の地区名, 年度, 事務所名が正しく表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
end
