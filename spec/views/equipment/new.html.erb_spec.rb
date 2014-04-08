require 'spec_helper'

describe "equipment/new" do
  before(:each) do
    assign(:equipment, stub_model(Equipment,
      :key => "MyString",
      :value => "MyString",
      :item_id => 1
    ).as_new_record)
  end

  it "renders new equipment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", equipment_index_path, "post" do
      assert_select "input#equipment_key[name=?]", "equipment[key]"
      assert_select "input#equipment_value[name=?]", "equipment[value]"
      assert_select "input#equipment_item_id[name=?]", "equipment[item_id]"
    end
  end
end
