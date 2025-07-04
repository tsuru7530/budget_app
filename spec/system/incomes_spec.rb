require 'rails_helper'

RSpec.describe "Incomes", type: :system do
  describe "#new" do
    before do
      @district = FactoryBot.create(:district)
    end
    it "districts#showからリンクをクリックすると遷移し、予算新規作成ページが表示される" do
      visit district_path(@district)
      expect(page).to have_content(@district.name)
      expect(page).to have_content(@district.year)
      expect(page).to have_content(@district.office)
      find(".fa-solid.fa-plus").click
      expect(page).to have_content("新規予算登録")
      expect(current_path).to eq new_income_path
    end
  end
  describe "#create" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.build(:income)
    end
    it "正常に登録できる" do
      visit new_income_path
      expect(page).to have_content("新規予算登録")
      select(@district.name, from: 'income[district_id]')
      fill_in('income[year]', with: @income.year)
      select(@income.category, from: 'income[category]')
      fill_in('income[price]', with: @income.price)
      fill_in('income[memo]', with: @income.memo)
      find('input[name="commit"]').click
      expect(page).to have_content(@district.name)
      expect(page).to have_content(@district.year)
      expect(page).to have_content(@district.office)
      expect(Income.count).to eq 1
      expect(current_path).to eq district_path(@district)
    end
    it "正常に登録できない(年度が空欄)" do
      visit new_income_path
      expect(page).to have_content("新規予算登録")
      select(@district.name, from: 'income[district_id]')
      select(@income.category, from: 'income[category]')
      fill_in('income[price]', with: @income.price)
      fill_in('income[memo]', with: @income.memo)
      find('input[name="commit"]').click
      expect(page).to have_content("新規予算登録")
      expect(Income.count).to eq 0
      expect(current_path).to eq new_income_path
    end
  end
  describe "#show" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
    end
    it "districts#showからリンクをクリックすると遷移し、予算詳細ページが表示される" do
      visit district_path(@district)
      expect(page).to have_content(@district.name)
      expect(page).to have_content(@district.year)
      expect(page).to have_content(@district.office)
      find(".fa-solid.fa-circle-info").click
      expect(page).to have_content("予算情報詳細")
      expect(current_path).to eq income_path(@income)
    end
  end
  describe "#edit" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
    end
    it "incomes#showからリンクをクリックすると遷移し、予算編集ページが表示される" do
      visit income_path(@income)
      expect(page).to have_content("予算情報詳細")
      find(".fa-solid.fa-pen-to-square").click
      expect(page).to have_content("予算情報編集")
      expect(current_path).to eq edit_income_path(@income)
    end
  end
  describe "#update" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
    end
    it "正しく更新される" do
      visit edit_income_path(@income)
      expect(page).to have_content("予算情報編集")
      fill_in('income[memo]', with: "hogehoge")
      find('input[name="commit"]').click
      expect(page).to have_content("予算情報詳細")
      expect(current_path).to eq income_path(@income)
    end
    it "正しく更新されない(備考が空欄)" do
      visit edit_income_path(@income)
      expect(page).to have_content("予算情報編集")
      fill_in('income[memo]', with: "")
      find('input[name="commit"]').click
      expect(page).to have_content("予算情報編集")
      expect(current_path).to eq edit_income_path(@income)
    end
  end
  describe "#destroy" do
    before do
      @district = FactoryBot.create(:district)
      @income = FactoryBot.create(:income, district_id: @district.id)
      @outgo = FactoryBot.create(:outgo, income_id: @income.id)
    end
    it "正常に削除できる(turbo_confirmをaccept)" do
      visit district_path(@district)
      page.accept_confirm do
        find(".fa-solid.fa-trash").click
      end
      expect(page).to have_content("地区情報詳細")
      expect(page).to have_content(@district.name)
      expect(page).to have_content(@district.year)
      expect(page).to have_content(@district.office)
      expect(Income.count).to eq 0
      expect(Outgo.count).to eq 0
      expect(current_path).to eq district_path(@district)
    end
    it "正常に削除できない(turbo_confirmをdismiss)" do
      visit district_path(@district)
      page.dismiss_confirm do
        find(".fa-solid.fa-trash").click
      end
      expect(page).to have_content("地区情報詳細")
      expect(Income.count).to eq 1
      expect(Outgo.count).to eq 1
      expect(current_path).to eq district_path(@district)
    end
  end
end
