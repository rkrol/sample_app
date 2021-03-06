require 'spec_helper'

describe "LayoutLinks" do

  it "should fine home page at'/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should find a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should find an about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should find a help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should find a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have the right link" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up!"
    response.should have_selector('title', :content => "Sign up")
  end

end