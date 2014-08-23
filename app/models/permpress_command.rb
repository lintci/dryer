class PermpressCommand
  attr_reader :linter, :files, :options

  def initialize(linter, files, options = [])
    @linter = linter
    @files = files
    @options = options
  end

  def run(io = $stdout)
    Bundler.with_clean_env do
      Open3.popen3(command) do |_, stdout, _, thread|
        yield stdout

        thread.value.exitstatus
      end
    end
  end

  def command
    "permpress #{linter.name} lint #{flags} #{arguments} 2>&1"
  end
  alias_method :to_s, :command

private

  def flags
    Shellwords.join(options)
  end

  def arguments
    Shellwords.join(files)
  end
end
