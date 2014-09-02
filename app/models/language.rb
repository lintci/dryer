require 'linguist'

# Tracks information about a programming language, such as whether it is lintable
class Language
  class << self
    def for(file_blob)
      class_name = class_name(file_blob.language)

      if Language.const_defined?(class_name)
        Language.const_get(class_name).new
      else
        Language::Null.new
      end
    end

    def class_name(language_name)
      language_name.gsub(
        /\+\+/,
        'PlusPlus'
      ).gsub(
        /#/,
        'Sharp'
      ).gsub(
        /[\s\-\+]/,
        ''
      ).to_sym
    end
  end

  def name
    raise NoMethodError, "#{self.class.name} must implement the name method."
  end

  def linters
    raise NoMethodError, "#{self.class.name} must implement the linters method."
  end

  def lintable?
    linters.any?
  end
end
