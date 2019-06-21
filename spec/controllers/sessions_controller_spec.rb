require 'rails_helper'

describe SessionsController, :type => :controller do

  describe "Login" do

    context "New" do

      it "should pop up the new member form" do
        get :new, params: {}, xhr: true, format: :js
        expect(response).to render_template('new')
      end

    end

    context "Create" do
      
      let(:member) { FactoryBot.create(:member, password: 'Password@123', password_confirmation: 'Password@123') }

      it "should allow member to login successfully and redirect" do
        post :create, params: { email: member.email, password: member.password }
        expect(session[:user_id]).to eq(member.id)
        expect(response).to redirect_to members_path  
      end

      it "should not allow member to login if email and password don't match" do
        post :create, params: { email: member.email, password: 'Password@1' }, xhr: true, format: :js
        expect(session[:user_id]).to be_nil
        expect(response).to render_template('new')
      end

    end

    context "Destroy" do

      let(:member) { FactoryBot.create(:member, password: 'Password@123', password_confirmation: 'Password@123') }

      before do
        session[:user_id] = member.id
      end

      it "should allow the member to sign out successfully and redirect" do
        delete :destroy, params: { id: member.id }
        expect(session[:user_id]).to be_nil
        # We could also do the following
        # expect(flash["success"]).to eq('Logged out!')
        expect(session["flash"]["flashes"]["success"]).to eq('Logged out!')
        expect(response).to redirect_to root_path
      end
      
    end

  end
  
end