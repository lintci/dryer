FactoryGirl.define do
  factory :git_delta, class: Rugged::Diff do
    patch{build(:git_patch)}

    initialize_with do
      patch.delta
    end
  end
end
