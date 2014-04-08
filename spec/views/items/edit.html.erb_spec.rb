require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "MyString",
      :short_desc => "MyString",
      :desc => "MyText",
      :location_id => 1,
      :media_id => 1,
      :type_id => 1
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_path(@item), "post" do
      assert_select "input#item_name[name=?]", "item[name]"
      assert_select "input#item_short_desc[name=?]", "item[short_desc]"
      assert_select "textarea#item_desc[name=?]", "item[desc]"
      assert_select "input#item_location_id[name=?]", "item[location_id]"
      assert_select "input#item_media_id[name=?]", "item[media_id]"
      assert_select "input#item_type_id[name=?]", "item[type_id]"
    end
  end
end
