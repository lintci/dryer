class PullRequest
  # Creates comments on pull requests
  class Comment
    def initialize(pull_request)
      @pull_request = pull_request
    end

    def add(file, line, message)
      client.create_pull_request_comment(
        repo,
        pull_request.id,
        message,
        pull_request.head_sha,
        file,
        line
      )
    end

  protected

    attr_reader :pull_request

  private

    def repo
      "#{pull_request.owner}/#{pull_request.repo}"
    end

    def client
      @client ||= Octokit::Client.new(
        login: 'defunkt',
        password: 'c0d3b4ssssss!'
      )
    end
  end
end
