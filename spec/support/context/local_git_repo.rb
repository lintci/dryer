require 'rugged'

shared_context 'local git repo' do
  let(:repositories_path){File.expand_path('../../../../tmp/repos', __FILE__)}
  let(:repo_path){File.join(repositories_path, 'test')}
  let(:repo) do
    Rugged::Repository.init_at(repo_path).tap do |repo|
      create_commit(repo, 'README.md')
      create_commit(repo, 'bad.rb', 'class b; end')
    end
  end
  let(:diff){repo.diff('HEAD~1', 'HEAD')}
  let(:patch){diff.patches.first}
  let(:delta){patch.delta}
  let(:hunk){patch.hunks.first}
  let(:line){hunk.lines.first}

  def create_commit(repo, file, content = 'test')
    index = stage_file(repo, file, content)

    Rugged::Commit.create(
      repo,
      tree: index.write_tree(repo),
      author: { email: 'testuser@example.com', name: 'Test Author', time: Time.now },
      committer: { email: 'testuser@example.com', name: 'Test Author', time: Time.now },
      message: "Adding #{file}",
      parents: repo.empty? ? [] : [repo.head.target].compact,
      update_ref: 'HEAD'
    )
  end

  def stage_file(repo, file, content)
    oid = repo.write(content, :blob)
    index = repo.index
    index.add(path: file, oid: oid, mode: 0100644)

    index
  end
end
