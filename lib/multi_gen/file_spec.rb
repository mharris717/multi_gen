module MultiGen
  class FileSpec 
    include FromHash
    attr_accessor :name, :project_type, :file_structure, :body_structure, :file_type, :list

    def run!(name)
      MultiGen.create file_name(name), body(name)
    end

    def file_name(name)
      file_structure.gsub_name(name)
    end

    def body(name)
      body_structure.gsub_name(name)
    end

    def match?(spec)
      project_type.to_s.downcase == spec.project_type.to_s.downcase && file_type.to_s.downcase == spec.file_type.to_s.downcase
    end

    def match_relative_path?(path)
      Structure.new(file_structure).match?(path)
    end

    def name_from_relative_path(path)
      Structure.new(file_structure).name(path)
    end

    def to_s
      "#{name} (#{project_type}) #{file_type}"
    end
  end

  class FileSpecWithBodyCommand < FileSpec
    def body(name)
      raise "no body"
    end
    def run!(name)
      MultiGen.ec body_structure.gsub_name(name)
    end
  end

  class FileSpecCompound < FileSpec
    fattr(:specs) do
      body_structure.map do |type|
        res = list.lookup(InputSpec.new(:project_type => project_type, :file_type => type))
        raise "can't find file spec for #{type}\n#{list}" unless res
        res
      end
    end
    def run!(name)
      specs.each { |x| x.run!(name) }
    end
  end

  class FileSpec
    class List
      include FromHash
      fattr(:files) { [] }
      def each(&b)
        files.each(&b)
      end
      def <<(x)
        x.list = self
        self.files << x
      end
      def lookup(spec)
        files.find do |f|
          f.match?(spec)
        end
      end

      def run!(spec)
        lookup(spec).run!(spec.name)
      end

      def spec_for_relative_path(rpath)
        files.find do |f|
          f.match_relative_path?(rpath)
        end
      end

      def to_s
        files.join("\n")
      end
    end
  end
end