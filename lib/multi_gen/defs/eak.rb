MultiGen.register do |d|
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

    p.template do |c|
      c.file "app/templates/NAME.hbs"
      c.body "{{each NAME in controller}}\n  {{NAME.name}}\n{{/each}}"
    end

    p.compound :resource => [:model,:controller,:template]

    p.create do |c|
      c.command "git clone https://github.com/stefanpenner/ember-app-kit.git NAME"
    end
  end
end