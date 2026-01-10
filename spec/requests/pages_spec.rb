require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "renders the home template" do
      get root_path
      expect(response.body).to include("Harayan")
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:success)
    end

    it "renders the about template" do
      get about_path
      expect(response.body).to include("About")
      expect(response.body).to include("会社概要")
    end
  end

  describe "GET /shops" do
    it "returns http success" do
      get shops_path
      expect(response).to have_http_status(:success)
    end

    it "renders the shops template" do
      get shops_path
      expect(response.body).to include("Shops")
      expect(response.body).to include("店舗情報")
    end
  end

  describe "GET /recruit" do
    it "returns http success" do
      get recruit_path
      expect(response).to have_http_status(:success)
    end

    it "renders the recruit template" do
      get recruit_path
      expect(response.body).to include("Recruit")
      expect(response.body).to include("採用情報")
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(:success)
    end

    it "renders the contact template" do
      get contact_path
      expect(response.body).to include("Contact")
      expect(response.body).to include("お問い合わせ")
    end
  end
end
