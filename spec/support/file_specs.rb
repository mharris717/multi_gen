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

  let(:file_specs) do
    res = MultiGen::FileSpec::List.new
    res << controller_spec
    res << model_spec
    res
  end
end