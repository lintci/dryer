FactoryGirl.define do
  factory :git_line, class: Rugged::Diff::Line do
    hunk{build(:git_hunk)}

    initialize_with do
      hunk.lines.first
    end
  end
end
