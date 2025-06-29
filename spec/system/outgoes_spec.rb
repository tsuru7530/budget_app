require 'rails_helper'

RSpec.describe "Outgoes", type: :system do
  describe "#new" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.build(:outgo, income_id: @income.id)
    end
    it "incomes#showからリンクをクリックすると遷移し、outgo作成ページが表示される" do
      visit income_path(@income)
      expect(page).to have_content(@income.year)
      expect(page).to have_content(@income.category)
      expect(page).to have_content(@income.price.to_fs(:delimited))
      find(".fa-solid.fa-plus").click
      expect(page).to have_selector('input[name="commit"]')
      expect(current_path).to eq new_income_outgo_path(@income)
    end
  end
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.build(:outgo, income_id: @income.id)
    end
    it "正常に登録できる" do
      visit new_income_outgo_path(@income)
      expect(page).to have_selector('input[name="commit"]')
      fill_in('outgo[year]', with: @outgo.year)
      fill_in('outgo[price]', with: @outgo.price)
      fill_in('outgo[memo]', with: @outgo.memo)
      find('input[name="commit"]').click
      expect(page).to have_content(@income.year)
      expect(page).to have_content(@income.category)
      expect(page).to have_content(@income.price.to_fs(:delimited))
      expect(page).to have_content(@income.memo)
      expect(Outgo.count).to eq 1
      expect(current_path).to eq income_path(@income)
    end
    it "正常に登録できない(yearが空欄)" do
      visit new_income_outgo_path(@income)
      expect(page).to have_selector('input[name="commit"]')
      fill_in('outgo[price]', with: @outgo.price)
      fill_in('outgo[memo]', with: @outgo.memo)
      find('input[name="commit"]').click
      expect(page).to have_selector('input[name="commit"]')
      expect(Outgo.count).to eq 0
      expect(current_path).to eq new_income_outgo_path(@income)
    end
  end
  describe "#edit" do
  end
  describe "#update" do
  end
  describe "#destroy" do
  end
end
