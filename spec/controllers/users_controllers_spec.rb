require 'spec_helper'
require 'factory_girl_rails'

describe UsersController do
	render_views

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should succeed" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profil image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

  end

  describe "GET 'new'" do

    it "should succeed" do
      get 'new'
      response.should be_success
    end

    it "should have a title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end

  end

end
