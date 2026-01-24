require 'rails_helper'

RSpec.describe "Navigation", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Header navigation" do
    it "navigates to About page from home" do
      visit root_path
      first("header nav").click_link "About"
      expect(page).to have_current_path(about_path)
      expect(page).to have_content("Company")
    end

    it "navigates to Stores page from home" do
      visit root_path
      first("header nav").click_link "Stores"
      expect(page).to have_current_path(stores_path)
      expect(page).to have_content("八十八")
    end

    it "navigates to Business page from home" do
      visit root_path
      first("header nav").click_link "Business"
      expect(page).to have_current_path(business_path)
      expect(page).to have_content("事業")
    end

    it "navigates to Recruit page from home" do
      visit root_path
      first("header nav").click_link "Recruit"
      expect(page).to have_current_path(recruit_path)
      expect(page).to have_content("募集要項")
    end

    it "navigates to Contact page from home" do
      visit root_path
      first("header nav").click_link "Contact"
      expect(page).to have_current_path(contact_path)
      expect(page).to have_content("お問い合わせ")
    end

    it "navigates back to home from logo" do
      visit about_path
      first("header a").click
      expect(page).to have_current_path(root_path)
    end
  end

  describe "Footer navigation" do
    it "has navigation links in footer" do
      visit root_path
      within "footer" do
        expect(page).to have_link("About")
        expect(page).to have_link("Stores")
        expect(page).to have_link("Business")
        expect(page).to have_link("Recruit")
        expect(page).to have_link("Contact")
      end
    end

    it "has store links in footer" do
      visit root_path
      within "footer" do
        expect(page).to have_link("八十八")
        expect(page).to have_link("A kyoto")
        expect(page).to have_link("B kyoto")
      end
    end
  end
end
