require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should validate false if there is no password" do
      @user = User.create(first_name: "Q", last_name: "J", email: "quinlan.jager@gmail.com", password:nil)
      expect(@user).to_not be_valid
    end

    it "should validate false if there the email is missing" do
      @user = User.create(first_name: "Q",
                          last_name: "J",
                          email: nil,
                          password:"112345678923")

      expect(@user).to_not be_valid
    end

    it "should validate false if there the first name is missing" do
      @user = User.create(first_name: nil,
                          last_name: "J",
                          email: "quinlan.jager@gmail.com",
                          password:"123456789")
      expect(@user).to_not be_valid
    end

    it "should validate false if there the last name is missing" do
      @user = User.create(first_name: "Q",
                          last_name: nil,
                          email: "quinlan.jager@gmail.com",
                          password:"123456789")
      expect(@user).to_not be_valid
    end

    it "should validate false if there is a matching email in the database" do
      @user1 = User.create(first_name: "Q", last_name: "J", email: "quinlan.jager@gmail.com", password:"123456789")
      @user2 = User.create(first_name: "Q", last_name: "J", email: "QUINLAN.JAGER@GMAIL.COM", password:"123456789")
      expect(@user2).to_not be_valid
    end

    it "should validate false if the password is less than 8 characters" do
      @user = User.create(first_name: "Q", last_name: "J", email: "quinlan.jager@gmail.com", password:"123")
      expect(@user).to_not be_valid
    end

    it "should include 'can\'t be less than 8 characters'" do
      @user = User.create(first_name: "Q", last_name: "J", email: "quinlan.jager@gmail.com", password:"123")
      expect(@user.errors.full_messages[0]).to include("can't be less than 8 characters")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(first_name: "Q", last_name: "J", email: "quinlan.jager@gmail.com", password:"123456789")
    end

    it "should return nil if password is incorrect" do
      expect(User.authenticate_with_credentials("quinlan.jager@gmail.com", "12345678")).to be(nil)
    end

    it "should return nil if email doesn't exist" do
      expect(User.authenticate_with_credentials("quinlan.jager@gmail.ca", "123456789")).to be(nil)
    end

    it "should return @user if the email does exisit" do
      @userInst = User.authenticate_with_credentials "quinlan.jager@gmail.com", "123456789"
      expect(@user.id).to eql(@userInst.id)
    end

    context "a user input" do
      it "should return @user, even if a few spaces are added to the end" do
        @userInst = User.authenticate_with_credentials "quinlan.jager@gmail.com  ", "123456789"
        expect(@user.id).to eql(@userInst.id)
      end

      it "should return @user, even if the incorrect casing is used on the email" do
        @userInst = User.authenticate_with_credentials "quinlan.jager@gmail.cOm", "123456789"
        expect(@user.id).to eql(@userInst.id)
      end
    end
  end
end
