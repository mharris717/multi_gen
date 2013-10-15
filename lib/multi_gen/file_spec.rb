module MultiGen
  class FileSpec 
    include FromHash
    attr_accessor :name, :project_type, :file_structure, :body_structure, :file_type

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
      project_type.to_s == spec.project_type.to_s && file_type.to_s == spec.file_type.to_s
    end
  end

  class FileSpec
    class List
      include FromHash
      fattr(:files) { [] }
      def <<(x)
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
    end
  end
end