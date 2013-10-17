shared_context "file specs" do
  let(:controller_spec) do
    res = MultiGen::FileSpec.new
    res.name = "EAK Controller"
    res.project_type = "EAK"
    res.file_type = :controller
    res.file_structure = "app/controllers/NAME.coffee"
    res.body_structure = "CAMEL_NAME = DS.Model.extend()"
    res
  end

  let(:model_spec) do
    res = MultiGen::FileSpec.new
    res.name = "EAK Model"
    res.project_type = "EAK"
    res.file_type = :model
    res.file_structure = "app/models/NAME.coffee"
    res.body_structure = "CAMEL_NAME = DS.Model.extend()"
    res
  end

  let(:resource_spec) do
    res = MultiGen::FileSpecCompound.new
    res.name = "EAK Resource"
    res.project_type = "EAK"
    res.file_type = :resource
    res.body_structure = [:model, :controller]
    res
  end

  let(:rails_model_spec) do
    res = MultiGen::FileSpecWithBodyCommand.new
    res.name = "EAK Model"
    res.project_type = "Rails"
    res.file_type = :model
    res.file_structure = "app/models/NAME.rb"
    res.body_structure = "rails g model NAME"
    res
  end

  let(:eak_create_spec) do
    res = MultiGen::FileSpecWithBodyCommand.new
    res.name = "EAK Create"
    res.project_type = :EAK
    res.file_type = :create
    res.body_structure = "gen NAME"
    res
  end

  let(:file_specs) do
    res = MultiGen::FileSpec::List.new
    res << rails_model_spec
    res << controller_spec
    res << model_spec
    res << resource_spec
    res
  end
end