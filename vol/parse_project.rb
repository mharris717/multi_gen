load File.dirname(__FILE__) + "/../lib/multi_gen.rb"

file_specs = SampleSpecs.new.file_specs

files = Dir["/code/orig/auction/front/**/*.coffee"]
files = files.reject { |x| x =~ /node_modules/ }
files = files.map { |x| x.gsub("/code/orig/auction/front/","") }

files.each do |f|
  spec = file_specs.spec_for_relative_path(f)
  if spec
    name = spec.name_from_relative_path(f)
    pre = "#{spec.file_type}:#{name}".rpad(25)
    puts "#{pre} - #{f}"
  end
end