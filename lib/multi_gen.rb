require 'mharris_ext'

%w(file_spec create_file project input_spec universe).each do |f|
  load File.dirname(__FILE__) + "/multi_gen/#{f}.rb"
end

class String
  def gsub_name(name)
    gsub("CAMEL_NAME",name.camelize).gsub("NAME",name)
  end
  def camelize
    self[0..0].upcase + self[1..-1]
  end
end

module MultiGen
  class << self
    def create(file,body)
      raise "foo"
    end
  end
end