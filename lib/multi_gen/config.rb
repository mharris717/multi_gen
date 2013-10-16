module MultiGen
  class Configs
    class << self
      fattr(:instance) { new }
      def method_missing(sym,*args,&b)
        instance.send(sym,*args,&b)
      end
    end

    include FromHash
    fattr(:file_specs) { FileSpec::List.new }
  end
end