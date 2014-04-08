require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :name => "Name",
        :short_desc => "Short Desc",
        :desc => "MyText",
        :location_id => 1,
        :media_id => 2,
        :type_id => 3
      ),
      stub_model(Item,
        :name => "Name",
        :short_desc => "Short Desc",
        :desc => "MyText",
        :location_id => 1,
        :media_id => 2,
        :type_id => 3
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Short Desc".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
