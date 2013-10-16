module MultiGen

  ##
  # A Project, which specifies a path and a type
  class Project
    include FromHash
    attr_accessor :base_path, :project_type

    def relative_path(path)
      res = path.gsub(base_path,"")
      raise "bad" if res == path
      res[1..-1]
    end
  end

  class Project
    class List
      include FromHash
      fattr(:projects) { [] }
      def <<(x)
        self.projects << x
      end
    end
  end
end

ProjectGroup::Single
class ProjectGroup::Single
  def relative_path(rpath)
    res = rpath.gsub(path,"")
    raise "bad" if res == rpath
    res[1..-1]
  end
  def base_path
    path
  end
end