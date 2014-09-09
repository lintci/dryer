FactoryGirl.define do
  factory :git_commit, class: Rugged::Commit do
    repo{build(:git_repo)}
    file 'README.md'
    content 'test'
    email 'testuser@example.com'
    author 'Test Author'

    initialize_with do
      oid = repo.write(content, :blob)
      index = repo.index
      index.add(path: file, oid: oid, mode: 0100644)

      Rugged::Commit.create(
        repo,
        tree: index.write_tree(repo),
        author: {email: email, name: author, time: Time.now},
        committer: {email: email, name: author, time: Time.now},
        message: "Adding #{file}",
        parents: repo.empty? ? [] : [repo.head.target].compact,
        update_ref: 'HEAD'
      )
    end

    trait :bad_ruby_file do
      file 'bad.rb'
      content 'class b; end'
    end
  end
end
