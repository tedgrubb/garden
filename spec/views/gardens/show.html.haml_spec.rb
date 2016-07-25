require 'spec_helper'

describe "gardens/show" do
  before(:each) do
    @garden = assign(:garden, stub_model(Garden,
      :name => "",
      :style => "",
      :user_id => "",
      :width => "",
      :length => "",
      :depth => "",
      :hours_of_sun => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
