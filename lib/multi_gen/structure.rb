module MultiGen
  class Structure
    attr_accessor :structure
    def initialize(s)
      @structure = s
    end

    fattr(:parts) do
      klass.split(structure)
    end

    def name(str)
      str_parts = klass.split(str)
      return false unless str_parts.length == parts.length

      res = nil
      parts.each_with_index do |part,i|
        str_part = str_parts[i]
        if part == str_part
          #nothing
        elsif 'NAME' == part
          res = str_part
        else
          return nil
        end
      end

      if res && res[-1..-1] == 's'
        res = res[0..-2]
      end
      res
    end
    def match?(str)
      !!name(str)
    end

    class << self
      def split(str)
        str.split(/[\/\.]/)
      end
    end
  end
end