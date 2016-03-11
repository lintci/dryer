require 'securerandom'

FactoryGirl.define do
  factory :source_file, aliases: [:ruby_source_file] do
    workdir
    id{SecureRandom.uuid}
    name 'bad.rb'
    sha 'cbc7b6a779837b93563e69511d44cb35051ed712'
    modified_lines((1..4).to_a)
    language 'Ruby'
    linters{LintTrap::Language.find(language).linters.map(&:name)}
    size 31
    binary false
    generated false
    vendored false
    documentation false
    image false
    extension{File.extname(name)}

    skip_create
    initialize_with{new(attributes)}

    trait :with_violations do
      violations{[attributes_for(:violation).deep_stringify_keys]}
    end

    factory :coffeescript_source_file do
      name 'bad.coffee'
      sha 'b045a0f5309273ce68e7cb52fc020769cef4a874'
      modified_lines [1]
      language 'CoffeeScript'
      size 11
    end

    factory :css_source_file do
      name 'bad.css'
      sha 'd6b3502a3e5b668fdbcb35c50457cde01b29657e'
      modified_lines((1..4).to_a)
      language 'CSS'
      size 58
    end

    factory :go_source_file do
      name 'bad.go'
      sha '9516ac5cd5eba1d6b9021468043de3a1ee2b2d9f'
      modified_lines((1..7).to_a)
      language 'Go'
      size 75
    end

    factory :java_source_file do
      name 'bad.java'
      sha 'a5e8bc51faa39fb83127ebe1bd9e21b82d438d03'
      modified_lines((1..3).to_a)
      language 'Java'
      size 22
    end

    factory :javascript_source_file do
      name 'bad.js'
      sha 'c6e2cbd471ae9be3ccd9657c4a28161fdf0b5454'
      modified_lines((1..3).to_a)
      language 'JavaScript'
      size 40
    end

    factory :json_source_file do
      name 'bad.json'
      sha '1c52b4bb17643f55e3484dba1ec61d95e762f483'
      modified_lines((1..4).to_a)
      language 'JSON'
      size 30
    end

    factory :scss_source_file do
      name 'bad.scss'
      sha '035313c6ebfecda56610bbc17a7ac0d26ce25886'
      modified_lines((1..3).to_a)
      language 'SCSS'
      size 22
    end

    factory :text_source_file do
      name 'lint.txt'
      sha 'dfea5994965f3bc2e0adaa57922f30b11c5bcf13'
      modified_lines [1]
      language 'Unknown'
      size 5
    end

    factory :png_source_file do
      name 'large.png'
      modified_lines []
      language 'Unknown'
      binary true
      image true
    end

    factory :license_source_file do
      name 'LICENSE'
      language 'Unknown'
      documentation true
    end

    factory :pdf_source_file do
      name 'arbitrary.pdf'
      modified_lines []
      language 'Unknown'
      binary true
    end
  end
end
