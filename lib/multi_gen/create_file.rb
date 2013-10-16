module MultiGen
  class CreateFile
    include FromHash
    attr_accessor :project, :file_spec, :input_spec

    def file_name
      "#{project.base_path}/#{file_spec.file_name(input_spec.name)}"
    end

    def body
      file_spec.body(input_spec.name)
    end

    def run!
      #MultiGen.create file_name, body
      Dir.chdir(project.base_path) do
        file_spec.run! input_spec.name
      end
    end
  end
end