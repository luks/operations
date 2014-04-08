require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image,
      :name => "MyString",
      :description => "MyText",
      :item_id => 1
    ))
  end

  it "renders the edit image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", image_path(@image), "post" do
      assert_select "input#image_name[name=?]", "image[name]"
      assert_select "textarea#image_description[name=?]", "image[description]"
      assert_select "input#image_item_id[name=?]", "image[item_id]"
    end
  end
end
