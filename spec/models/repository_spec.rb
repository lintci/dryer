require 'spec_helper'
require 'models/pull_request'
require 'models/repository'
require 'fileutils'

describe Repository do
  let(:repositories_path){File.expand_path('../../../tmp/repos', __FILE__)}

  describe '.clone', :integration, :github do
    let(:repository_file){File.join(repositories_path, 'lintci/guinea_pig/mostly-bad/1/bad.json')}
    let(:pull_request_data){json_fixture_file('github/pull_request_opened_payload.json')['pull_request']}
    let(:pull_request){PullRequest.new(pull_request_data)}
    let(:build_id){1}

    it 'clones the repository to the correct directory' do
      Repository.clone(repositories_path, pull_request, build_id) do
        expect(File).to exist(repository_file)
      end
    end

    it 'destroys the repository when the call to clone completes' do
      Repository.clone(repositories_path, pull_request, build_id){}

      expect(File).to_not exist(repository_file)
    end

    it 'yields a repository' do
      expect do |b|
        Repository.clone(repositories_path, pull_request, build_id, &b)
      end.to yield_with_args(be_a(Repository))
    end
  end

  context 'with initialized repository' do
    include_context 'local git repo'
    subject(:repository){Repository.new(repo, 'lintci/guinea_pig/mostly-bad')}

    after(:each){FileUtils.rm_rf(repo_path)}

    its(:branch){is_expected.to eq('master')}
    its(:local_path){is_expected.to eq(repo_path)}
  end
end
