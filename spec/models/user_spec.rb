# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
    	:name => "Example User", 
    	:email => "user@example.com",
    	:password => "userpass",
    	:password_confirmation => "userpass" 
    }
  end

  it "should create a new instance with validated attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    bad_guy = User.new(@attr.merge(:name => ""))
    bad_guy.should_not be_valid
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject too long name" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email address" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email adress" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject double email" do
  	upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "shoud require a corresponding password_confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject a too short password" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject a too long password" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have a crypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should define a crypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "shoud return true if the password is valid" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "should return false if the password is not valid" do
        @user.has_password?("invalid").should be_false
      end

    end

    describe "authenticate method" do

      it "should return nil if email/password are not valid" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil if email is not registered" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user object email/password are valid" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end

  end

end
