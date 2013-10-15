require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include MultiGen

describe "Combine" do
  include_context "file specs"

  let(:spec) do
    InputSpec.new(:project_type => "EAK", :file_type => :controller, :name => "widget")
  end

  let(:project) do
    Project.new(:base_path => "/a/b", :project_type => "EAK")
  end

  let(:create_file) do
    CreateFile.new(:input_spec => spec, :project => project, :gen_file => controller_spec)
  end

  it 'file_name' do
    create_file.file_name.should == "/a/b/app/controllers/widget.coffee"
  end

  it 'body' do
    create_file.body.should == "Widget = DS.Model.extend()"
  end
end