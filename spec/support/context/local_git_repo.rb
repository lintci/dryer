require 'rugged'

shared_context 'local git repo' do
  let(:repo_path){repo.path.sub('/.git/', '')}
  let(:repo){build(:git_repo, :bad_ruby_file)}
  let(:diff){build(:git_diff, repo: repo)}
  let(:patch){build(:git_patch, diff: diff)}
  let(:delta){build(:git_delta, patch: patch)}
  let(:hunk){build(:git_hunk, patch: patch)}
  let(:line){build(:git_line, hunk: hunk)}

  after(:each) do
    FileUtils.rm_rf(repo_path, {})
  end
end
