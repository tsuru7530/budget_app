require 'rails_helper'

RSpec.describe "Districts", type: :request do
  describe "#index" do
    context "districtの一覧ページが正しく表示される(district未登録の場合)" do
      before do
        get districts_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "ページタイトルが表示されている" do
        expect(response.body).to include("district list")
      end
      it '表題が表示されていない'  do
        expect(response.body).to_not include("district name")
        expect(response.body).to_not include("year")
        expect(response.body).to_not include("office")
      end
    end
    context "districtの一覧ページが正しく表示される(district登録済みの場合)" do
      before do
        @district = FactoryBot.create(:district)
        get districts_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it '表題が表示されている'  do
        expect(response.body).to include("district name")
        expect(response.body).to include("year")
        expect(response.body).to include("office")
      end
      it '作成したdistrictのname, year, bodyが正しく表示されている'  do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
  describe "#new" do
    context "districtの新規作成ページが正しく表示される" do
      before do
        get new_district_path
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
    end
  end
  describe "#show" do
    context "districtの詳細ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        get district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "作成したdistrictのname, year, bodyが正しく表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
  describe "#edit" do
    context "districtの更新ページが正しく表示される" do
      before do
        @district = FactoryBot.create(:district)
        get edit_district_path(@district)
      end
      it "リクエストは200 OKとなる" do
        expect(response.status).to eq 200
      end
      it "作成したdistrictのname, year, bodyが正しく表示されている" do
        expect(response.body).to include(@district.name)
        expect(response.body).to include(@district.year)
        expect(response.body).to include(@district.office)
      end
    end
  end
end
