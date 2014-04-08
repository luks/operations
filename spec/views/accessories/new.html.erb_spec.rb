require 'spec_helper'

describe "accessories/new" do
  before(:each) do
    assign(:accessory, stub_model(Accessory,
      :key => "MyString",
      :value => "MyText",
      :item_id => 1
    ).as_new_record)
  end

  it "renders new accessory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accessories_path, "post" do
      assert_select "input#accessory_key[name=?]", "accessory[key]"
      assert_select "textarea#accessory_value[name=?]", "accessory[value]"
      assert_select "input#accessory_item_id[name=?]", "accessory[item_id]"
    end
  end
end
