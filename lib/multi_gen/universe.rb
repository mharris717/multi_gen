module MultiGen
  class Universe
    include FromHash
    fattr(:projects) { Project::List.new }
    fattr(:file_specs) { FileSpec::List.new }
  end
end