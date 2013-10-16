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
      # i supply a relative path, you get me the file spec
      path = "app/controllers/widget.coffee"
      res = file_specs.spec_for_relative_path(path)
      res.name.should == "EAK Controller"
      res.name_from_relative_path(path).should == 'widget'
    end

    it 'lookup from plural path' do
      # i supply a relative path, you get me the file spec
      path = "app/controllers/widgets.coffee"
      res = file_specs.spec_for_relative_path(path)
      res.name.should == "EAK Controller"
      res.name_from_relative_path(path).should == 'widget'
    end
  end

  describe "model" do
    let(:spec) do
      InputSpec.new(:project_type => "EAK", :file_type => :model, :name => "widget")
    end

    it 'lookup' do
      file_specs.lookup(spec).should == model_spec
    end

    it 'lookup from path' do
      # i supply a relative path, you get me the file spec
      res = file_specs.spec_for_relative_path("app/models/widget.coffee")
      res.name.should == "EAK Model"
    end

  end

  describe "rails model" do
    let(:spec) do
      InputSpec.new(:project_type => "Rails", :file_type => :model, :name => "widget")
    end

    it 'lookup' do
      file_specs.lookup(spec).should == rails_model_spec
    end

    it "creates file" do
      MultiGen.should_receive(:ec).with("rails g model widget")
      file_specs.run! spec
    end
  end

  describe "resource" do
    let(:spec) do
      InputSpec.new(:project_type => "EAK", :file_type => :resource, :name => "widget")
    end

    it 'lookup' do
      file_specs.lookup(spec).should == resource_spec
    end

    it "creates file" do
      MultiGen.should_receive(:create).with("app/controllers/widget.coffee","Widget = DS.Model.extend()")
      MultiGen.should_receive(:create).with("app/models/widget.coffee","Widget = DS.Model.extend()")
      file_specs.run! spec
    end
  end
end