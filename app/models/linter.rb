# Base class for linters
class Linter
  def initialize(name, workdir, source_files)
    @linter = LintTrap::Linter.find(name)
    @containter = LintTrap::Container::Docker.new('lintci/lint_trap', workdir)
    @source_files = source_files
  end

  def lint(options)
    started_at, clean = Time.now, true

    each_linted_file(options) do |source_file|
      finished_at, clean = Time.now, false

      yield source_file, started_at, finished_at

      started_at = finished_at
    end

    clean
  end

protected

  attr_reader :linter, :container, :source_files

private

  def each_linted_file(options)
    each_violation = linter.to_enum(:lint, files.keys, container, options)
    each_file_violations = each_violation.chunk{|violation| violation[:file]}

    each_file_violations.each do |file, violations|
      yield files[file].with(violations: violations)
    end
  end

  def files
    @files ||= source_files.each_with_object({}) do |file, files|
      files[file.name] = file
    end
  end
end

# ruby:
#   rubocop:
#     exclude:
#       - **/*_spec.rb
#     include:
#       - Rakefile
#       - Gemfile
#     config: .rubocop.yml
