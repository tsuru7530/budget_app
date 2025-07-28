require 'rails_helper'

RSpec.describe "Districts", type: :system do
  describe "#index" do
    it "地区未登録の場合" do
      visit root_path
      expect(page).to have_content("地区一覧")
      expect(page).not_to have_content("地区検索")
    end
    it "地区登録済みの場合" do
      FactoryBot.create(:district)
      visit root_path
      expect(page).to have_content("地区一覧")
      expect(page).to have_content("地区検索")
    end
  end
  describe "#show" do
    it "indexからリンクをクリックすると遷移し、作成した地区の情報が表示される" do
      @district = FactoryBot.create(:district)
      visit root_path
      expect(page).to have_selector(".fa-solid.fa-circle-info")
      find(".fa-solid.fa-circle-info").click
      expect(page).to have_content("#{@district.name}")
      expect(page).to have_content("#{@district.year}")
      expect(page).to have_content("#{@district.office}")
      expect(current_path).to eq district_path(@district)
    end
  end
  describe "#new" do
    it "indexからリンクをクリックすると遷移し、新規地区作成ページが表示される" do
      visit root_path
      find('.fa-solid.fa-plus').click
      expect(page).to have_content("新規地区登録")
      expect(current_path).to eq new_district_path
    end
  end
  describe "#create" do
    before do
      @district = FactoryBot.build(:district)
    end
    it "正常に登録できる" do
      visit new_district_path
      expect(page).to have_content("新規地区登録")
      fill_in('district_name', with: @district.name)
      fill_in('district_year', with: @district.year)
      fill_in('district_office', with: @district.office)
      attach_file('district[image]', "spec/fixtures/test_image.png", make_visible: true)
      find('input[name="commit"]').click
      expect(page).to have_content("地区一覧")
      expect(District.count).to eq 1
      expect(current_path).to eq root_path
    end
    it "正常に登録できない(地区名が空欄)" do
      visit new_district_path
      expect(page).to have_content("新規地区登録")
      expect(current_path).to eq new_district_path
      fill_in('district_year', with: @district.year)
      fill_in('district_office', with: @district.office)
      attach_file('district[image]', "spec/fixtures/test_image.png", make_visible: true)
      find('input[name="commit"]').click
      expect(page).to have_content("新規地区登録")
      expect(District.count).to eq 0
      expect(current_path).to eq new_district_path 
    end
  end
  describe "#edit" do
    before do
      @district = FactoryBot.create(:district)
    end
    it "indexからリンクをクリックすると遷移し、編集ページが表示される" do
      visit root_path
      find(".fa-solid.fa-pen-to-square").click
      expect(page).to have_content("地区情報編集")
      expect(current_path).to eq edit_district_path(@district)
    end
  end
  describe "#update" do
    before do
      @district = FactoryBot.create(:district)
    end
    it "正常に更新できる(地区名のみ変更)" do
      visit edit_district_path(@district)
      expect(page).to have_content("地区情報編集")
      fill_in('district_name', with: "#{@district.name}changed")
      find('input[name="commit"]').click
      expect(page).to have_content("地区一覧")
      expect(District.count).to eq 1
      expect(current_path).to eq root_path
    end
    it "正常に更新できない(地区名が空欄)" do
      visit edit_district_path(@district)
      expect(page).to have_content("地区情報編集")
      fill_in('district_name', with: "")
      find('input[name="commit"]').click
      expect(page).to have_content("地区情報編集")
      expect(District.count).to eq 1
      expect(current_path).to eq edit_district_path(@district) 
    end
  end
  describe "#destroy" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.create(:outgo, income_id: @income.id)
    end
    it "正常に削除できる(turbo_confirmをaccept)" do
      visit root_path
      page.accept_confirm do
        find(".fa-solid.fa-trash").click
      end
      expect(page).to have_content("地区一覧")
      expect(District.count).to eq 0
      expect(Income.count).to eq 0
      expect(Outgo.count).to eq 0
      expect(current_path).to eq root_path
    end
      it "正常に削除できない(turbo_confirmをdismiss)" do
      visit root_path
      page.dismiss_confirm do
        find(".fa-solid.fa-trash").click
      end
      expect(page).to have_content("地区一覧")
      expect(District.count).to eq 1
      expect(Income.count).to eq 1
      expect(Outgo.count).to eq 1
      expect(current_path).to eq root_path
    end
  end
  describe "#search" do
    before do
      @district_matched = FactoryBot.create(:district, name: "hoge", year: "7", office: "hoge")
      @district_unmatched = FactoryBot.create(:district, name: "fuga", year: "8", office: "fuga")
    end
    it "地区名が正しく検索できる" do
      visit root_path
      expect(page).to have_content("地区一覧")
      select '地区名', from: 'category'
      fill_in('inputword', with: "hoge")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("地区一覧(検索結果)")
      expect(page).to have_content(@district_matched.name)
      expect(page).to have_content(@district_matched.year)
      expect(page).to have_content(@district_matched.office)
      expect(page).not_to have_content(@district_unmatched.name)
      expect(page).not_to have_content(@district_unmatched.year)
      expect(page).not_to have_content(@district_unmatched.office)
      expect(current_path).to match(".*search.*")
    end
    it "年度が正しく検索できる" do
      visit root_path
      expect(page).to have_content("地区一覧")
      select '年度', from: 'category'
      fill_in('inputword', with: "7")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("地区一覧(検索結果)")
      expect(page).to have_content(@district_matched.name)
      expect(page).to have_content(@district_matched.year)
      expect(page).to have_content(@district_matched.office)
      expect(page).not_to have_content(@district_unmatched.name)
      expect(page).not_to have_content(@district_unmatched.year)
      expect(page).not_to have_content(@district_unmatched.office)
      expect(current_path).to match(".*search.*")
    end
    it "事務所名が正しく検索できる" do
      visit root_path
      expect(page).to have_content("地区一覧")
      select '事務所名', from: 'category'
      fill_in('inputword', with: "hoge")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("地区一覧(検索結果)")
      expect(page).to have_content(@district_matched.name)
      expect(page).to have_content(@district_matched.year)
      expect(page).to have_content(@district_matched.office)
      expect(page).not_to have_content(@district_unmatched.name)
      expect(page).not_to have_content(@district_unmatched.year)
      expect(page).not_to have_content(@district_unmatched.office)
      expect(current_path).to match(".*search.*")
    end
  end
end
