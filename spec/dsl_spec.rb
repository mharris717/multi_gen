def run_dsl(d)
  d.project :eak do |p|
    p.compound :model do |c|
      c.model do |m|
        m.file "app/models/NAME.coffee"
        m.body "CAMEL_NAME = DS.Model.extend()\n\n`export default CAMEL_NAME`"
      end

      c.test do |s|
        s.file "tests/unit/NAME_test.coffee"
        s.body "Test Stuff"
      end
    end

    p.compound :controller do |c|
      c.controller do |m|
        m.file "app/controllers/NAME.coffee"
        m.body "CAMEL_NAMEController = EM.ObjectController.extend()\n\n`export default CAMEL_NAMEController`"
      end

      c.test do |s|
        s.file "tests/acceptance/NAME_test.coffee"
        s.body "Test Stuff"
      end
    end

    p.compound :resource => [:model,:controller]
  end

  17
end

def run_dsl_rails(d)
  d.project :rails do |p|
    d.model do |m|
      m.command "rails g model NAME"
    end

    d.resource do |m|
      m.command "rails g resource NAME"
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include MultiGen

describe "FileSpecs" do
  let(:dsl) do
    DSL::Wrapper.new
  end

  it 'smoke' do
    run_dsl(dsl).should be
  end

  it 'leaf specs' do
    run_dsl(dsl)
    dsl.specs.size.should == 7
  end

  it 'spec names' do
    run_dsl(dsl)
    dsl.specs.map { |x| x.file_type.to_s }.sort.should == %w(model controller model-model model-test controller-controller controller-test resource).sort
    #dsl.specs.find { |x| x.file_type == 'model' }.should be
  end

  it 'spec deps' do
    run_dsl(dsl)
    spec = dsl.specs.find { |x| x.file_type.to_s == 'model' }
    spec.should be
    spec.body_structure.should == ["model-model","model-test"]
  end

  it 'rails command' do
    run_dsl_rails(dsl)
    dsl.specs.size.should == 2
    dsl.specs.first.should be_kind_of(FileSpecWithBodyCommand)
  end
end