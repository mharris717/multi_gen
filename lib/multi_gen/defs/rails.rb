MultiGen.register do |d|
  d.project :rails do |p|
    p.model do |m|
      m.command "rails g model NAME"
    end

    p.resource do |m|
      m.command "rails g resource NAME"
    end

    p.create do |c|
      c.command "rails new NAME"
    end
  end
end