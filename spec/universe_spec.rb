require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include MultiGen

describe "Universe" do
  include_context "file specs"
  include_context "projects"

  let(:spec) do
    InputSpec.new(:project_type => "EAK", :file_type => :controller, :name => "widget")
  end

  let(:universe) do
    Universe.new(:projects => projects, :file_specs => file_specs)
  end

  it 'smoke' do
    universe.should be
  end
end


