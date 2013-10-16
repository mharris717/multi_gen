module MultiGen

  ##
  # Specification for the kind of file you want to create
  class InputSpec
    include FromHash
    attr_accessor :project_type, :file_type, :name

    def to_s
      "#{project_type} #{file_type} #{name}"
    end
  end
end