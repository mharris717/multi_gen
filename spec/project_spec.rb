require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include MultiGen

describe "Project" do
  let(:project) do
    Project.new(:base_path => "/a/b", :project_type => "EAK")
  end

  it 'relative_path' do
    project.relative_path("/a/b/app/widget.coffee").should == "app/widget.coffee"
  end

  it 'bad relative path' do
    lambda { project.relative_path("junk") }.should raise_error
  end
end