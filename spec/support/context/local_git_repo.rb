require 'rugged'

shared_context 'local git repo' do
  let(:repositories_path){File.expand_path('../../../../tmp/repos', __FILE__)}
  let(:repo_path){File.join(repositories_path, 'test')}
  let(:repo) do
    build(:git_repo, :bad_ruby_file)
  end
  let(:diff){build(:git_diff)}
  let(:patch){build(:git_patch)}
  let(:delta){build(:git_delta)}
  let(:hunk){build(:git_hunk)}
  let(:line){build(:git_line)}
end
