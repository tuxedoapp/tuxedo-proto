require 'spec_helper'

describe "Activity".upcase.colorize(:light_blue) do

  ## Dummy Vendors
  before do
    @vendor = Vendor.create(name: "Boulder Skydiving", email: "Vendor1@example.com", location: "Boulder",
                            zip_code: 80301, password: "mypassword1", password_confirmation: "mypassword1")
  end

  before do 
    @activity =  Activity.create(name: "Skydiving", price: 150.00,  location: "Boulder",
                              description: "Ipsum splitsum", vendor_id: 1) 
  end

  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  it { should be_valid }

#------------------------------------
  describe "\nCheck parameters for blankness".upcase.colorize(:light_blue) do
    describe "when name is not present" do
      before { @activity.name = " " }
      it { should_not be_valid }
    end

    describe "when location is not present" do
      before { @activity.location = " " }
      it { should_not be_valid }
    end

    describe "when price is not present" do
      before { @activity.price = nil }
      it { should_not be_valid }
    end
  end

  describe "\nactivity Validation".upcase.colorize(:light_blue) do

    describe "when name is too long" do
      before { @activity.name = "z" * 51 }
      it { should_not be_valid }
    end

    describe "when location is too long" do
      before { @activity.location = "z" * 31 }
      it { should_not be_valid }
    end

    describe "when price format is valid" do
      it "it should be valid" do
        prices = [10.00, 150.00, 600.00, 0]
        prices.each do |valid|
          @activity.price = valid
          expect(@activity).to be_valid
        end
      end
    end

    describe "when vendor ID does not exist" do
      before { @activity.vendor_id = 3473498572345896 }
      it { should_not be_valid }
    end
  end
#------------------------------------
# Description
  describe "\ndescription".upcase.colorize(:light_blue) do
    describe "when activity has a valid description" do
      before { @activity.description = "Ipsum schplitsum" }
      it { should be_valid }
    end

    describe "when activity does not have description" do
      before { @activity.description = "" }
      it { should_not be_valid }
    end

    describe "when activity description is too long" do
      before { @activity.description = "a" * 161 }
      it { should_not be_valid }
    end
  end
end