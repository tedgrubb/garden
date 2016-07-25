require 'spec_helper'

describe "plants/index" do
  before(:each) do
    assign(:plants, [
      stub_model(Plant,
        :name => "Name",
        :garden_id => 1,
        :x_pos => 2,
        :y_pos => 3,
        :days_to_harvest => 4
      ),
      stub_model(Plant,
        :name => "Name",
        :garden_id => 1,
        :x_pos => 2,
        :y_pos => 3,
        :days_to_harvest => 4
      )
    ])
  end

  it "renders a list of plants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
