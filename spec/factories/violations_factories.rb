FactoryGirl.define do
  factory :violations do
    initialize_with do
      new(
        '1' => build(:single_line_violations, line: '1'),
        '2' => build(:line_violations, line: '2')
      )
    end

    factory :empty_violations do
      initialize_with{new}
    end

    factory :single_violations do
      initialize_with{new('1' => build(:single_line_violations, line: '1'))}
    end
  end
end
