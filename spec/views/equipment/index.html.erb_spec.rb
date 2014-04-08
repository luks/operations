require 'spec_helper'

describe "equipment/index" do
  before(:each) do
    assign(:equipment, [
      stub_model(Equipment,
        :key => "Key",
        :value => "Value",
        :item_id => 1
      ),
      stub_model(Equipment,
        :key => "Key",
        :value => "Value",
        :item_id => 1
      )
    ])
  end

  it "renders a list of equipment" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
