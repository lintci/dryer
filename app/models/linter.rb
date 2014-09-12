# Base class for linters
class Linter
  def lint(files, config_file)
    permpress_command.run(files, config_file) do |io|
      yield_violations_by_file(io)
    end
  end

  def command_name
    raise NotImplementedError, 'Linters must specify their command name.'
  end

private

  def yield_violations_by_file(io)
    file = nil

    LintTrap.parse(io) do |violation|
      if linting_new_file?(file, violation)
        yield file unless file.nil?

        file = LintedFile.new(violation[:file])
      end

      file.add_violation(violation)
    end

    yield file unless file.nil?
  end

  def linting_new_file?(file, violation)
    file.nil? || violation[:file] != file.name
  end

  def permpress_command
    PermpressCommand.new(self)
  end
end
