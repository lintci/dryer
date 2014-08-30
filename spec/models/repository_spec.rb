require 'spec_helper'
require 'models/payload'
require 'models/repository'

describe Repository do
  describe '.clone', :integration, :github do
    let(:repositories_path){File.expand_path('../../../tmp/repos', __FILE__)}
    let(:repository_file){File.join(repositories_path, 'lintci/guinea_pig/mostly-bad/1/bad.json')}
    let(:payload_data){json_fixture_file('github/pull_request_opened_payload.json')}
    let(:payload){Payload.new(payload_data)}
    let(:build_id){1}

    it 'clones the repository to the correct directory' do
      Repository.clone(repositories_path, payload, build_id) do
        expect(File).to exist(repository_file)
      end
    end

    it 'destroys the repository when the call to clone completes' do
      Repository.clone(repositories_path, payload, build_id){}

      expect(File).to_not exist(repository_file)
    end

    it 'yields a repository' do
      expect do |b|
        Repository.clone(repositories_path, payload, build_id, &b)
      end.to yield_with_args(be_a(Repository))
    end
  end

  context 'with initialized repository' do
    let(:repo_path){fixture_file('repos/test')}
    let(:repo){Rugged::Repository.new(repo_path)}
    subject(:repository){Repository.new(repo, 'lintci', 'guinea_pig')}

    its(:branch){is_expected.to eq('master')}
    its(:local_path){is_expected.to eq(repo_path)}
  end
end
