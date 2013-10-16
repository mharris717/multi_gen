module MultiGen
  class Command
    include FromHash
    attr_accessor :cmd, :file_type, :name, :dir

    fattr(:project) do
      ProjectGroup::Configs.loaded.single_for_dir(dir, :safe => true)
    end

    fattr(:input_spec) do
      #raise "Dir: #{dir}\n" + ProjectGroup::Configs.loaded.to_s
      MultiGen::InputSpec.new(:project_type => project.type, :file_type => file_type, :name => name)
    end

    fattr(:file_spec) do
      Configs.file_specs.lookup(input_spec).tap do |res| 
        if !res
          str = Configs.file_specs.files.join("\n")
          raise ["no file spec","Input Spec: #{input_spec}",str].join("\n") 
        end
      end
    end

    fattr(:create_file) do
      MultiGen::CreateFile.new(:project => project, :file_spec => file_spec, :input_spec => input_spec)
    end

    def run!
      #puts create_file.file_name
      #puts create_file.body
      create_file.run!
    end

    class << self
      def from_argv(argv)
        new(:cmd => argv[0], :file_type => argv[1], :name => argv[2], :dir => argv[3] || File.expand_path(Dir.getwd))
      end
    end
  end
end