require 'securerandom'

FactoryGirl.define do
  factory :violation do
    id{SecureRandom.uuid}
    line '2'
    column '7'
    length '4'
    rule 'Style/MethodName'
    severity 'convention'
    message 'Use snake_case for method names.'

    initialize_with{new(attributes)}

    factory :minimal_violation do
      column nil
      length nil
      rule nil
      severity nil
    end
  end
end
