# Base class for linters
class Linter
  def initialize(name, workdir, source_files)
    @linter = LintTrap::Linter.find(name)
    @workdir = Pathname.new(workdir)
    @container = LintTrap::Container::Docker.new(linter.image_version, workdir)
    @source_files = source_files
  end

  def setup
    started_at = Time.zone.now
    container.pull

    [container.image, started_at, Time.zone.now]
  end

  def lint(options)
    started_at = Time.zone.now
    clean = true

    each_linted_file(options) do |source_file|
      finished_at = Time.zone.now
      clean = false

      yield source_file, started_at, finished_at

      started_at = finished_at
    end

    clean
  end

protected

  attr_reader :linter, :workdir, :container, :source_files

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
      files[workdir.join(file.name).to_s] = file
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
