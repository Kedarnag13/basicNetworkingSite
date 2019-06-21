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

  context "Friendship" do

    context "Accept" do

      it "should allow to send and accept friend request" do
        member1 = FactoryBot.create(:member)
        session[:user_id] = member1.id
        member2 = FactoryBot.create(:member)
        put :add_as_friend, params: { id: member2 }
        expect(member1.friends_with?(member2)).to be_truthy
        expect(member1.friends).to include(member2)
        expect(response).to redirect_to members_path
      end

      it "should not allow to send and accept friend request without user logged in" do
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member)
        put :add_as_friend, params: { id: member2 }
        expect(session["flash"]["flashes"]["alert"]).to eq('You must be logged in to access this page.')
        expect(response).to redirect_to root_path
      end

    end

    context "Remove" do

      it "should allow the logged in user to remove friend from list" do
        member1 = FactoryBot.create(:member)
        session[:user_id] = member1.id
        member2 = FactoryBot.create(:member)
        member1.friend_request(member2)
        member2.accept_request(member1)
        put :remove_friend, params: { id: member2 }
        expect(member1.friends_with?(member2)).to be_falsey
        expect(member1.friends).not_to include(member2)
        expect(response).to redirect_to members_path
      end

    end

    context "My Profile" do

      before do
        member1 = FactoryBot.create(:member)
        session[:user_id] = member1.id
      end

      it "should allow the logged in user to see his profile" do
        get :my_profile, params: {}
        expect(response).to render_template('my_profile')
      end

      it "should not allow to see ones profile if not logged in" do
        session[:user_id] = nil
        get :my_profile, params: {}
        expect(session["flash"]["flashes"]["alert"]).to eq('You must be logged in to access this page.')
        expect(response).to redirect_to root_path
      end

    end

    context "Search" do

      before do
        member1 = FactoryBot.create(:member)
        session[:user_id] = member1.id
      end

      it "should allow to search for other members to connect" do
        member2 = FactoryBot.create(:member, name: 'RKReloaded')
        get :search, params: { member_name: 'rk' }
        expect(response).to render_template('search')
      end

    end

  end

end
