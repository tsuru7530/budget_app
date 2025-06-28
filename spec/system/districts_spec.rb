require 'rails_helper'

RSpec.describe "Districts", type: :system do
  describe "#create" do
    before do
      @district = FactoryBot.build(:district)
    end
    it "正常に登録できる" do
      visit root_path
      expect(page).to have_selector(".fa-solid.fa-plus")
      find('.fa-solid.fa-plus').click
      expect(page).to have_selector('input[name="commit"]')
      expect(current_path).to eq new_district_path
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
      visit root_path
      expect(page).to have_selector(".fa-solid.fa-plus")
      find('.fa-solid.fa-plus').click
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
end
