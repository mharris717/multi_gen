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
    CreateFile.new(:input_spec => spec, :project => project, :file_spec => controller_spec)
  end

  it 'file_name' do
    create_file.file_name.should == "/a/b/app/controllers/widget.coffee"
  end

  it 'body' do
    create_file.body.should == "Widget = DS.Model.extend()"
  end
end

describe "Combine - create" do
  include_context "file specs"

  let(:spec) do
    InputSpec.new(:project_type => "EAK", :file_type => :controller, :name => "widget")
  end

  fattr(:dir_name) do
    rand(1000000000).to_s
  end

  let(:project) do
    dir = File.expand_path(File.dirname(__FILE__) + "/../tmp")
    Project.new(:base_path => "#{dir}/#{dir_name}", :project_type => "EAK")
  end

  let(:create_file) do
    CreateFile.new(:input_spec => spec, :project => project, :file_spec => eak_create_spec)
  end

  it 'body' do
    MultiGen.should_receive(:ec).with("gen #{dir_name}")
    create_file.run!

  end
end