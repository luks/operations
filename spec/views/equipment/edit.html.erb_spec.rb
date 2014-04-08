require 'spec_helper'

describe "equipment/edit" do
  before(:each) do
    @equipment = assign(:equipment, stub_model(Equipment,
      :key => "MyString",
      :value => "MyString",
      :item_id => 1
    ))
  end

  it "renders the edit equipment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", equipment_path(@equipment), "post" do
      assert_select "input#equipment_key[name=?]", "equipment[key]"
      assert_select "input#equipment_value[name=?]", "equipment[value]"
      assert_select "input#equipment_item_id[name=?]", "equipment[item_id]"
    end
  end
end
