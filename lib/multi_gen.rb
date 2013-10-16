require 'mharris_ext'

if !defined?(ProjectGroup)
  require 'project_group' 
end

class Object
  def klass
    self.class
  end
end

module MultiGen
  class << self
    def register(&b)
      dsl = DSL::Wrapper.new
      b[dsl]
      dsl.specs.each do |s|
        MultiGen::Configs.file_specs << s
      end
    end
  end
end

%w(file_spec create_file project input_spec universe command structure config dsl).each do |f|
  load File.dirname(__FILE__) + "/multi_gen/#{f}.rb"
end

%w(eak rails).each do |f|
  load File.dirname(__FILE__) + "/multi_gen/defs/#{f}.rb"
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
      raise "Exists" if FileTest.exist?(file)
      File.create file, body
    end
    def ec(cmd)
      MharrisExt.ec(cmd)
    end
  end
end



ProjectGroup.register_plugin("g") do |p,ops|
  rem = ops[:remaining_args]
  cmd = MultiGen::Command.new(:cmd => "g", :file_type => rem[0], :name => rem[1], :dir => p.path)
  cmd.run!
end



