require 'spec_helper'

describe "User pages".upcase.colorize(:light_blue) do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Location",     with: "Invalid"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        check   "I wish to be a vendor on this site"
      end

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Location",     with: "Boulder"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        uncheck "I wish to be a vendor on this site"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end