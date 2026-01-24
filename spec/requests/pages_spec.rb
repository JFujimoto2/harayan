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
      expect(response.body).to include("Company")
    end
  end

  describe "GET /stores" do
    it "returns http success" do
      get stores_path
      expect(response).to have_http_status(:success)
    end

    it "renders the stores template" do
      get stores_path
      expect(response.body).to include("Stores")
      expect(response.body).to include("八十八")
    end
  end

  describe "GET /shops (legacy redirect)" do
    it "redirects to stores" do
      get "/shops"
      expect(response).to redirect_to(stores_path)
    end
  end

  describe "GET /business" do
    it "returns http success" do
      get business_path
      expect(response).to have_http_status(:success)
    end

    it "renders the business template" do
      get business_path
      expect(response.body).to include("Business")
      expect(response.body).to include("事業")
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
      expect(response.body).to include("募集要項")
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
