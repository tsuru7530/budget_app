require 'rails_helper'

RSpec.describe "Districts", type: :system do
  describe "#index" do
    it "district未登録の場合" do
      visit root_path
      expect(page).to have_content("district list")
      expect(page).not_to have_selector(".fa-solid.fa-magnifying-glass")
    end
    it "district登録済みの場合" do
      FactoryBot.create(:district)
      visit root_path
      expect(page).to have_content("district list")
      expect(page).to have_selector(".fa-solid.fa-magnifying-glass")
    end
  end
  describe "#show" do
    it "indexからリンクをクリックすると遷移し、作成したdistrictの情報が表示される" do
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
    it "indexからリンクをクリックすると遷移し、新規作成ページが表示される" do
      visit root_path
      find('.fa-solid.fa-plus').click
      expect(page).to have_selector('input[name="commit"]')
      expect(current_path).to eq new_district_path
    end
  end
  describe "#create" do
    before do
      @district = FactoryBot.build(:district)
    end
    it "正常に登録できる" do
      visit new_district_path
      expect(page).to have_selector('input[name="commit"]')
      fill_in('district_name', with: @district.name)
      fill_in('district_year', with: @district.year)
      fill_in('district_office', with: @district.office)
      attach_file('district[image]', "spec/fixtures/test_image.png")
      find('input[name="commit"]').click
      expect(page).to have_selector(".fa-solid.fa-plus")
      expect(District.count).to eq 1
      expect(current_path).to eq root_path
    end
    it "正常に登録できない(nameが空欄)" do
      visit new_district_path
      expect(page).to have_selector('input[name="commit"]')
      expect(current_path).to eq new_district_path
      fill_in('district_year', with: @district.year)
      fill_in('district_office', with: @district.office)
      attach_file('district[image]', "spec/fixtures/test_image.png")
      find('input[name="commit"]').click
      expect(page).to have_selector('input[name="commit"]')
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
      expect(page).to have_selector('input[name="commit"]')
      expect(current_path).to eq edit_district_path(@district)
    end
  end
  describe "#update" do
    before do
      @district = FactoryBot.create(:district)
    end
    it "正常に登録できる(nameのみ変更)" do
      visit edit_district_path(@district)
      expect(page).to have_selector('input[name="commit"]')
      fill_in('district_name', with: "#{@district.name}changed")
      find('input[name="commit"]').click
      expect(page).to have_selector(".fa-solid.fa-magnifying-glass")
      expect(District.count).to eq 1
      expect(current_path).to eq root_path
    end
    it "正常に登録できない(nameが空欄)" do
      visit edit_district_path(@district)
      expect(page).to have_selector('input[name="commit"]')
      fill_in('district_name', with: "")
      find('input[name="commit"]').click
      expect(page).to have_selector('input[name="commit"]')
      expect(District.count).to eq 1
      expect(current_path).to eq edit_district_path(@district) 
    end
  end
  describe "#destroy" do
    before do
      @district = FactoryBot.create(:district)
    end
    it "正常に削除できる" do
      visit root_path
      find(".fa-solid.fa-trash").click
      find("OK").click
      expect(page).to have_content("district list")
      expect(District.count).to eq 0
      expect(current_path).to eq root_path
    end
  end
  describe "#search" do
    before do
      @district_matched = FactoryBot.create(:district, name: "hoge", year: "7", office: "hoge")
      @district_unmatched = FactoryBot.create(:district, name: "fuga", year: "8", office: "fuga")
    end
    it "nameが正しく検索できる" do
      visit root_path
      expect(page).to have_content("district list")
      select 'name', from: 'category'
      fill_in('inputword', with: "hoge")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("district list (search result)")
      expect(page).to have_content(@district_matched.name)
      expect(page).to have_content(@district_matched.year)
      expect(page).to have_content(@district_matched.office)
      expect(page).not_to have_content(@district_unmatched.name)
      expect(page).not_to have_content(@district_unmatched.year)
      expect(page).not_to have_content(@district_unmatched.office)
      expect(current_path).to match(".*search.*")
    end
    it "yearが正しく検索できる" do
      visit root_path
      expect(page).to have_content("district list")
      select 'year', from: 'category'
      fill_in('inputword', with: "7")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("district list (search result)")
      expect(page).to have_content(@district_matched.name)
      expect(page).to have_content(@district_matched.year)
      expect(page).to have_content(@district_matched.office)
      expect(page).not_to have_content(@district_unmatched.name)
      expect(page).not_to have_content(@district_unmatched.year)
      expect(page).not_to have_content(@district_unmatched.office)
      expect(current_path).to match(".*search.*")
    end
    it "officeが正しく検索できる" do
      visit root_path
      expect(page).to have_content("district list")
      select 'office', from: 'category'
      fill_in('inputword', with: "hoge")
      find(".fa-solid.fa-magnifying-glass").click
      expect(page).to have_content("district list (search result)")
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
