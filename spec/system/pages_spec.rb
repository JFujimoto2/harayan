require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Home page" do
    it "displays hero section" do
      visit root_path
      expect(page).to have_content("Harayan")
      expect(page).to have_content("お客様に最高の体験をお届けします")
    end

    it "displays concept section" do
      visit root_path
      expect(page).to have_content("Concept")
    end

    it "displays service cards" do
      visit root_path
      expect(page).to have_content("Services")
      expect(page).to have_link(href: shops_path)
      expect(page).to have_link(href: recruit_path)
      expect(page).to have_link(href: contact_path)
    end

    it "displays CTA section" do
      visit root_path
      expect(page).to have_content("お気軽にお問い合わせください")
    end
  end

  describe "About page" do
    it "displays philosophy section" do
      visit about_path
      expect(page).to have_content("Philosophy")
      expect(page).to have_content("Mission")
      expect(page).to have_content("Vision")
      expect(page).to have_content("Value")
    end

    it "displays company information" do
      visit about_path
      expect(page).to have_content("Company")
      expect(page).to have_content("株式会社Harayan")
    end
  end

  describe "Shops page" do
    it "displays shop information" do
      visit shops_path
      expect(page).to have_content("Harayan 本店")
      expect(page).to have_content("営業時間")
      expect(page).to have_content("定休日")
    end

    it "displays map section" do
      visit shops_path
      expect(page).to have_content("Map")
    end
  end

  describe "Recruit page" do
    it "displays recruitment message" do
      visit recruit_path
      expect(page).to have_content("一緒に働きませんか？")
    end

    it "displays ideal candidate section" do
      visit recruit_path
      expect(page).to have_content("求める人物像")
    end

    it "displays job requirements" do
      visit recruit_path
      expect(page).to have_content("募集要項")
      expect(page).to have_content("募集職種")
      expect(page).to have_content("仕事内容")
      expect(page).to have_content("給与")
    end

    it "has application button" do
      visit recruit_path
      expect(page).to have_link("応募する", href: contact_path)
    end
  end

  describe "Contact page" do
    it "displays contact information" do
      visit contact_path
      expect(page).to have_content("ご質問・ご相談など、お気軽にお問い合わせください")
    end

    it "displays google form placeholder" do
      visit contact_path
      expect(page).to have_content("Googleフォーム埋め込みエリア")
    end

    it "displays phone and email" do
      visit contact_path
      expect(page).to have_content("お電話")
      expect(page).to have_content("メール")
      expect(page).to have_content("03-0000-0000")
    end
  end
end
