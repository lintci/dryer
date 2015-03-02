class Classification
  class Group
    attr_reader :linter, :language, :modified_files

    def initialize(linter, language, modified_files = [])
      @linter = linter
      @language = language
      @modified_files = modified_files
    end

    def <<(file)
      @modified_files << file
    end

    def ==(other)
      linter == other.linter &&
        language == other.language &&
        modified_files == other.modified_files
    end

    def read_attribute_for_serialization(name)
      public_send(name)
    end
  end
end
