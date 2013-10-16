module MultiGen
  module DSL
    class Wrapper
      include FromHash
      fattr(:base_ops) { {} }
      fattr(:leaves) { [] }
      attr_accessor :file_spec
      attr_accessor :file_type_prefix

      def specs
        res = []
        res << file_spec if file_spec
        res += leaves.map { |x| x.specs }.flatten
        res
      end

      def project(name,&b)
        res = new_wrapper(:project_type => name,&b)
        self.leaves << res
      end

      def after_compound(name)
        ops = base_ops.merge(:file_type => name)
        ops[:body_structure] = leaves.map do |leaf| 
          leaf.file_spec.file_type
        end
        self.file_spec = make_file_spec(FileSpecCompound,ops)
      end

      def after_compound_hash(name,deps)
        ops = base_ops.merge(:file_type => name)
        ops[:body_structure] = deps
        self.file_spec = make_file_spec(FileSpecCompound,ops)
      end

      def compound(name,&b)
        if block_given?
          wrap = new_wrapper({})
          wrap.file_type_prefix = name
          b[wrap]
          wrap.after_compound(name)
          self.leaves << wrap
        elsif name.kind_of?(Hash)
          deps = name.values.first
          name = name.keys.first
          wrap = new_wrapper({})
          wrap.after_compound_hash(name,deps)
          self.leaves << wrap
        end
      end

      def method_missing(sym,*args,&b)
        if b
          raise "has args" unless args.empty?
          sym = "#{file_type_prefix}-#{sym}" if file_type_prefix
          res = new_wrapper(:file_type => sym,&b)
          self.leaves << res
          res.file_spec = res.make_file_spec(FileSpec,res.base_ops)
        else
          raise "bad args #{sym} #{args.inspect} #{block_given?} #{b}" unless args.size == 1
          self.base_ops[sym] = args.first
        end
      end

      def make_file_spec(cls,base_ops)
        ops = {}
        base_ops.each do |k,v|
          if [:file,:body].include?(k)
            k = "#{k}_structure".to_sym 
          elsif k == :command
            cls = FileSpecWithBodyCommand
            k = :body_structure
          end
          ops[k] = v
        end
        ops[:name] = "Gen #{ops[:project_type]} #{ops[:file_type]}"

        raise "bad spec #{ops.inspect}" unless ops[:file_type]

        cls.new(ops)
      end

      def new_wrapper(ops,&b)
        res = klass.new(:base_ops => base_ops.merge(ops))
        yield(res) if block_given?
        res
      end
    end

  end
end