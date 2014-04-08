require 'spec_helper'

describe "equipment/show" do
  before(:each) do
    @equipment = assign(:equipment, stub_model(Equipment,
      :key => "Key",
      :value => "Value",
      :item_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Key/)
    rendered.should match(/Value/)
    rendered.should match(/1/)
  end
end
