require 'spec_helper'

describe "accessories/index" do
  before(:each) do
    assign(:accessories, [
      stub_model(Accessory,
        :key => "Key",
        :value => "MyText",
        :item_id => 1
      ),
      stub_model(Accessory,
        :key => "Key",
        :value => "MyText",
        :item_id => 1
      )
    ])
  end

  it "renders a list of accessories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
