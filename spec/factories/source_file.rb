FactoryGirl.define do
  factory :source_file, aliases: [:ruby_source_file] do
    workdir
    name 'bad.rb'
    modified_lines (1..4).to_a
    language LintTrap::Language::Ruby.new
    size 31
    binary false
    generated false
    vendored false
    documentation false
    image false
    extension{File.extname(name)}

    skip_create
    initialize_with do
      new(
        workdir: workdir,
        name: name,
        modified_lines: modified_lines,
        language: language,
        size: size,
        binary: binary,
        generated: generated,
        vendored: vendored,
        documentation: documentation,
        image: image,
        extension: extension
      )
    end

    factory :coffeescript_source_file do
      name 'bad.coffee'
      modified_lines [1]
      language LintTrap::Language::CoffeeScript.new
      size 11
    end

    factory :css_source_file do
      name 'bad.css'
      modified_lines (1..4).to_a
      language LintTrap::Language::CSS.new
      size 58
    end

    factory :go_source_file do
      name 'bad.go'
      modified_lines (1..7).to_a
      language LintTrap::Language::Go.new
      size 75
    end

    factory :java_source_file do
      name 'bad.java'
      modified_lines (1..3).to_a
      language LintTrap::Language::Java.new
      size 22
    end

    factory :javascript_source_file do
      name 'bad.js'
      modified_lines (1..3).to_a
      language LintTrap::Language::JavaScript.new
      size 40
    end

    factory :json_source_file do
      name 'bad.json'
      modified_lines (1..4).to_a
      language LintTrap::Language::JSON.new
      size 30
    end

    factory :scss_source_file do
      name 'bad.scss'
      modified_lines (1..3).to_a
      language LintTrap::Language::SCSS.new
      size 22
    end

    factory :text_source_file do
      name 'lint.txt'
      modified_lines [1]
      language LintTrap::Language::Unknown.new('Text')
      size 5
    end
  end
end
