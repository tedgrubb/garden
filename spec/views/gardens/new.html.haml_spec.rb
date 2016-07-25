require 'spec_helper'

describe "gardens/new" do
  before(:each) do
    assign(:garden, stub_model(Garden,
      :name => "",
      :style => "",
      :user_id => "",
      :width => "",
      :length => "",
      :depth => "",
      :hours_of_sun => ""
    ).as_new_record)
  end

  it "renders new garden form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", gardens_path, "post" do
      assert_select "input#garden_name[name=?]", "garden[name]"
      assert_select "input#garden_style[name=?]", "garden[style]"
      assert_select "input#garden_user_id[name=?]", "garden[user_id]"
      assert_select "input#garden_width[name=?]", "garden[width]"
      assert_select "input#garden_length[name=?]", "garden[length]"
      assert_select "input#garden_depth[name=?]", "garden[depth]"
      assert_select "input#garden_hours_of_sun[name=?]", "garden[hours_of_sun]"
    end
  end
end
