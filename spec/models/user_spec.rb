require 'spec_helper'
require 'faker'

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end

  context "email validations" do
    it "should require an email address" do
      user = build(:user, email: "")
      user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        user = build(:user, email: address)
        user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        user = build(:user, email: address)
        user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      address = Faker::Internet.email
      create(:user, email: address)
      user = build(:user, email: address)
      user.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      address = Faker::Internet.email
      create(:user, email: address.upcase)
      user = build(:user, email: address)
      user.should_not be_valid
    end
  end

  context "password" do
    before(:each) do
      @user = build(:user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  context "password validations" do
    it "should require a password" do
      build(:user, password: "", password_confirmation: "").should_not be_valid
    end

    it "should require a matching password confirmation" do
      build(:user, password_confirmation: "invalid").should_not be_valid
    end

    it "should reject short passwords" do
      # short = Faker::Internet.password(5)
      short = "short"
      build(:user, password: short, password_confirmation: short).should_not be_valid
    end
  end

  context "password encryption" do
    before(:each) do
      @user = create(:user)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
  end

  context "#admin" do
    it 'builds non-admin user by default' do 
      create(:user).should have_field(:admin).of_type(Mongoid::Boolean).with_default_value_of(false) 
    end
  end

  context '.admins' do
    it 'returns admin users' do
      first_user = create(:admin)
      second_user = create(:admin)
      third_user = create(:user)

      result = User.admins

      expect(result).to eq [first_user, second_user]
    end
  end
  
  context '.non_admins' do
    it 'returns non admin users' do
      first_user = create(:user)
      second_user = create(:user)
      third_user = create(:admin)

      result = User.non_admins

      expect(result).to eq [first_user, second_user]
    end
  end
end
