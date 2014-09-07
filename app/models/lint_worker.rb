# Lints
class LintWorker < Thread
  def initialize(pull_request, linter, modified_files, subscription)
    super(linter, modified_files, subscription) do
      linter.lint(modified_files) do |linted_file|
        relevant_violations = linted_file.relevant_violations(modified_files)
        comment(pull_request, linted_file, relevant_violations)
      end
    end
  end

private

  def comment(pull_request, file, violations)
    violations.grouped_by_line do |line, line_violations|
      pull_request.comment(file, line, line_violations)
    end
  end
end
