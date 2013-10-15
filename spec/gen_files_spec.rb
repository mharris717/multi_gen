require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include MultiGen

describe "FileSpecs" do
  include_context "file specs"

  describe "controller" do
    let(:spec) do
      InputSpec.new(:project_type => "EAK", :file_type => :controller, :name => "widget")
    end

    it 'lookup' do
      file_specs.lookup(spec).should == controller_spec
    end

    it "creates file" do
      MultiGen.should_receive(:create).with("app/controllers/widget.coffee","Widget = DS.Model.extend()")
      file_specs.run! spec
    end

    it 'lookup from path' do

    end
  end

  describe "model" do
    let(:spec) do
      InputSpec.new(:project_type => "EAK", :file_type => :model, :name => "widget")
    end

    it 'lookup' do
      file_specs.lookup(spec).should == model_spec
    end
  end
end