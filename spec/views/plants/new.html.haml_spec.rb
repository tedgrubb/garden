require 'spec_helper'

describe "plants/new" do
  before(:each) do
    assign(:plant, stub_model(Plant,
      :name => "MyString",
      :garden_id => 1,
      :x_pos => 1,
      :y_pos => 1,
      :days_to_harvest => 1
    ).as_new_record)
  end

  it "renders new plant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plants_path, "post" do
      assert_select "input#plant_name[name=?]", "plant[name]"
      assert_select "input#plant_garden_id[name=?]", "plant[garden_id]"
      assert_select "input#plant_x_pos[name=?]", "plant[x_pos]"
      assert_select "input#plant_y_pos[name=?]", "plant[y_pos]"
      assert_select "input#plant_days_to_harvest[name=?]", "plant[days_to_harvest]"
    end
  end
end
