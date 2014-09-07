FactoryGirl.define do
  factory :line_violations do
    line '2'

    initialize_with{new(line, build_list(:violation, 2, line: line))}

    factory :empty_line_violations do
      initialize_with{new(line, [])}
    end

    factory :single_line_violations do
      initialize_with{new(line, build_list(:violation, 1, line: line))}
    end
  end
end
