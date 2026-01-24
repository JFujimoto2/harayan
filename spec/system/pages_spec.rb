require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Home page" do
    it "displays hero section" do
      visit root_path
      expect(page).to have_content("Harayan")
      expect(page).to have_content("光をとどける")
    end

    it "displays concept section" do
      visit root_path
      expect(page).to have_content("Concept")
    end

    it "displays store cards" do
      visit root_path
      expect(page).to have_content("Stores")
      expect(page).to have_link(href: store_8108_path)
      expect(page).to have_link(href: store_a_kyoto_path)
      expect(page).to have_link(href: store_b_kyoto_path)
    end

    it "displays CTA section" do
      visit root_path
      expect(page).to have_content("お問い合わせ")
    end
  end

  describe "About page" do
    it "displays philosophy section" do
      visit about_path
      expect(page).to have_content("Our Philosophy")
      expect(page).to have_content("Mission")
      expect(page).to have_content("Vision")
      expect(page).to have_content("Value")
    end

    it "displays company information" do
      visit about_path
      expect(page).to have_content("Company")
      expect(page).to have_content("Harayan")
    end
  end

  describe "Stores page" do
    it "displays store cards" do
      visit stores_path
      expect(page).to have_content("八十八")
      expect(page).to have_content("A kyoto")
      expect(page).to have_content("B kyoto")
    end

    it "has links to individual stores" do
      visit stores_path
      expect(page).to have_link(href: store_8108_path)
      expect(page).to have_link(href: store_a_kyoto_path)
      expect(page).to have_link(href: store_b_kyoto_path)
    end
  end

  describe "Individual store pages" do
    it "displays 八十八 page" do
      visit store_8108_path
      expect(page).to have_content("八十八")
      expect(page).to have_content("Japanese Tea Stand")
      expect(page).to have_content("浅草")
    end

    it "displays A kyoto page" do
      visit store_a_kyoto_path
      expect(page).to have_content("A kyoto")
      expect(page).to have_content("Japanese Cuisine")
    end

    it "displays B kyoto page" do
      visit store_b_kyoto_path
      expect(page).to have_content("B kyoto")
      expect(page).to have_content("Craft Gin")
    end
  end

  describe "Business page" do
    it "displays business content" do
      visit business_path
      expect(page).to have_content("Business")
      expect(page).to have_content("飲食店舗の企画・運営")
      expect(page).to have_content("卸売")
    end
  end

  describe "Recruit page" do
    it "displays recruitment message" do
      visit recruit_path
      expect(page).to have_content("一緒に")
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

    it "displays contact form" do
      visit contact_path
      expect(page).to have_field("お名前")
      expect(page).to have_field("メールアドレス")
      expect(page).to have_field("お問い合わせ内容")
      expect(page).to have_button("送信する")
    end

    it "displays phone and email" do
      visit contact_path
      expect(page).to have_content("お電話")
      expect(page).to have_content("メール")
      expect(page).to have_content("03-0000-0000")
    end
  end
end
