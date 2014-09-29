 require 'rails_helper'

 describe Item do

  describe "description" do

  before do
    @item = create(:item)
  end 

  it "returns the items description" do
    expect(@item.description).to eq("Get water")
  end

  end
 end