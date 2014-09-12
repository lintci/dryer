require 'open3'

# Wraps execution of a permpress linting command
class PermpressCommand
  attr_reader :linter

  def initialize(linter)
    @linter = linter
  end

  def run(files, config_file)
    Bundler.with_clean_env do
      Open3.popen3(command(files, config_file)) do |_, stdout, _, thread|
        yield stdout

        thread.value.exitstatus
      end
    end
  end

  def command(files, config_file)
    "permpress #{linter.command_name} lint #{flags(config_file)}#{arguments(files)} 2>&1"
  end

private

  def flags(config_file)
    "--config #{config_file} " if config_file
  end

  def arguments(files)
    Shellwords.join(files)
  end
end
