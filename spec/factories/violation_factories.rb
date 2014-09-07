FactoryGirl.define do
  factory :violation do
    line '2'
    column '7'
    length '4'
    rule 'Style/MethodName'
    severity 'convention'
    message 'Use snake_case for methods.'

    initialize_with{new(attributes)}
  end
end
