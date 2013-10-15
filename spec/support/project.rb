shared_context "projects" do
  let(:project_auction) do
    MultiGen::Project.new(:base_path => "/code/orig/auction", :project_type => :EAK)
  end

  let(:project_rails) do
    MultiGen::Project.new(:base_path => "/code/orig/bar", :project_type => :Rails)
  end

  let(:projects) do
    res = MultiGen::Project::List.new
    res << project_auction
    res << project_rails
    res
  end
end