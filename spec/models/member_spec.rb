require 'rails_helper'

describe Member do

  describe "Validations" do

    context "New" do

      it "should not be valid without password" do
        member = FactoryBot.build(:member, password: nil, password_confirmation: nil)
        expect(member).to_not be_valid  
      end

      it "should not be valid for password which are short" do
        member = FactoryBot.build(:member, password: 'abcd', password_confirmation: 'abcd')
        expect(member).to_not be_valid
      end

      it "should not be valid if password and password confirmation do not match" do
        member = FactoryBot.build(:member, password: 'abcd', password_confirmation: 'pqrs')
        expect(member).to_not be_valid  
      end

    end

    context "Existing" do

      let(:member) { FactoryBot.create(:member, password: 'Password@123', password_confirmation: 'Password@123') }

      it "should be valid" do
        expect(member).to be_valid  
      end

      it "should not be valid if the password is empty" do
        member.password = ""
        member.password_confirmation = ""
        expect(member).to_not be_valid  
      end

      it "should be valid with updated password" do
        member.password = "Password@12"
        member.password_confirmation = "Password@12"
        expect(member).to be_valid  
      end

    end

  end

end
