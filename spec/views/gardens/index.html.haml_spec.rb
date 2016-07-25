require 'spec_helper'

describe "gardens/index" do
  before(:each) do
    assign(:gardens, [
      stub_model(Garden,
        :name => "",
        :style => "",
        :user_id => "",
        :width => "",
        :length => "",
        :depth => "",
        :hours_of_sun => ""
      ),
      stub_model(Garden,
        :name => "",
        :style => "",
        :user_id => "",
        :width => "",
        :length => "",
        :depth => "",
        :hours_of_sun => ""
      )
    ])
  end

  it "renders a list of gardens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
