require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "Name",
      :short_desc => "Short Desc",
      :desc => "MyText",
      :location_id => 1,
      :media_id => 2,
      :type_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Short Desc/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
