FactoryGirl.define do
  factory :modified_file, aliases: [:ruby_modified_file] do
    workdir
    name 'bad.rb'
    lines (1..4).to_a
    language LintTrap::Language::Ruby.new

    skip_create
    initialize_with{new(workdir, name, lines, language)}

    factory :coffeescript_modified_file do
      name 'bad.coffee'
      lines [1]
      language LintTrap::Language::CoffeeScript.new
    end

    factory :css_modified_file do
      name 'bad.css'
      lines (1..4).to_a
      language LintTrap::Language::CSS.new
    end

    factory :go_modified_file do
      name 'bad.go'
      lines (1..7).to_a
      language LintTrap::Language::Go.new
    end

    factory :java_modified_file do
      name 'bad.java'
      lines (1..3).to_a
      language LintTrap::Language::Java.new
    end

    factory :javascript_modified_file do
      name 'bad.js'
      lines (1..3).to_a
      language LintTrap::Language::JavaScript.new
    end

    factory :json_modified_file do
      name 'bad.json'
      lines (1..4).to_a
      language LintTrap::Language::JSON.new
    end

    factory :scss_modified_file do
      name 'bad.scss'
      lines (1..3).to_a
      language LintTrap::Language::SCSS.new
    end

    factory :text_modified_file do
      name 'lint.txt'
      lines [1]
      language nil
    end
  end
end
