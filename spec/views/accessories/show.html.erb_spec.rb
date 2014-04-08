require 'spec_helper'

describe "accessories/show" do
  before(:each) do
    @accessory = assign(:accessory, stub_model(Accessory,
      :key => "Key",
      :value => "MyText",
      :item_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Key/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
