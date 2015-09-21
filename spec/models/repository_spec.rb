require 'spec_helper'
require 'fileutils'

describe Repository do
  let(:repositories_path){build(:repos_dir)}

  describe '.clone', :integration, :github do
    let(:repository_file){File.join(repositories_path, "#{task.slug}/bad.json")}
    let(:task){build(:task)}

    after(:each){FileUtils.rm_r(repositories_path, force: true)}

    it 'clones the repository to the correct directory' do
      Repository.clone(repositories_path, task) do
        expect(File).to exist(repository_file)
      end
    end

    it 'destroys the repository when the call to clone completes' do
      Repository.clone(repositories_path, task){}

      expect(File).to_not exist(repository_file)
    end

    it 'yields a repository' do
      expect do |b|
        Repository.clone(repositories_path, task, &b)
      end.to yield_with_args(be_a(Repository), be_a(Time), be_a(Time))
    end

    it 'checks out the correct commit' do
      Repository.clone(repositories_path, task) do |repo|
        expect(repo.head_sha).to eq(task.head_sha)
      end
    end
  end

  describe '#source_files' do
    let(:repo){instance_double(Rugged::Repository)}
    let(:base_sha){build(:base_sha)}
    let(:head_sha){build(:head_sha)}
    let(:diff){instance_double(Repository::Diff)}
    subject(:repository){Repository.new(repo)}

    it 'delegates to repository diff' do
      expect(Repository::Diff).to receive(:new).with(repo, base_sha, head_sha).and_return(diff)
      expect(diff).to receive(:source_files)

      repository.source_files(base_sha, head_sha)
    end
  end

  describe '#inspect' do
    let(:repo){instance_double(Rugged::Repository, workdir: '/right_here')}
    subject(:repository){Repository.new(repo)}

    it 'formats repository display' do
      expect(repository.inspect).to eq('<Repository: /right_here>')
    end
  end
end
