FactoryGirl.define do
  factory :group, class: Classification::Group do
    linter LintTrap::Linter::RuboCop.new
    language LintTrap::Language::Ruby.new

    skip_create
    initialize_with do
      Classification::Group.new(linter, language)
    end
  end
end
