module MultiGen
  class CreateFile
    include FromHash
    attr_accessor :project, :gen_file, :input_spec

    def file_name
      "#{project.base_path}/#{gen_file.file_name(input_spec.name)}"
    end

    def body
      gen_file.body(input_spec.name)
    end
  end
end