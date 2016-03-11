require 'json-schema'

RSpec::Matchers.define :validate_against_schema do |schema|
  match do |json|
    @json = json.deep_stringify_keys
    @errors = JSON::Validator.fully_validate(schema, @json)
    expect(@errors).to be_empty
  end

  failure_message do
    "expected json to match schema, but instead found these errors:\n"\
    "#{@errors.map{|error| "\t" + error}.join("\n")}\n\n"\
    "JSON was:\n#{JSON.pretty_generate(@json)}"
  end
end
