require 'rails_helper'

describe MembersController, :type => :controller do

  context "Index" do

    before do
      member = FactoryBot.create(:member)
      session[:user_id] = member.id
    end
    
    it "should list all the members except the logged in" do
      get :index, params: {}
      expect(response).to render_template('index')
    end

    it "should not list all the members if member is not logged in" do
      session[:user_id] = nil
      get :index, params: {}
      expect(response).to redirect_to root_path
      expect(session["flash"]["flashes"]["alert"]).to eq('You must be logged in to access this page.')
    end

  end

  context "New" do

    it "should pop up the new member form" do
      get :new, params: {}, xhr: true, format: :js
      expect(response).to render_template('new')
    end

  end

  context "Create" do

    it "should be able to create member" do
      expect{
        post :create, params: { name: Faker::Name.name, original_url: 'https://news.google.com/?hl=en-SG&gl=SG&ceid=SG:en', email: Faker::Internet.email, password: 'Password@123', password_confirmation: 'Password@123' }
      }.to change{ Member.count }.by(1)
    end

    it "should allow to create member with the same email" do
      FactoryBot.create(:member, email: 'abc@yopmail.com')
      expect{
        post :create, params: { name: Faker::Name.name, original_url: 'https://news.google.com/?hl=en-SG&gl=SG&ceid=SG:en', email: 'abc@yopmail.com', password: 'Password@123', password_confirmation: 'Password@123'  }
      }.to change{ Member.count }.by(0)
    end

  end

end
