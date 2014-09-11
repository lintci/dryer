require 'json'

# Provides helpers for accessing fixture files
module FixtureFile
  def fixture_file(path)
    base_path = File.expand_path('../../fixtures', __FILE__)
    File.join(base_path, path)
  end

  def read_fixture_file(path)
    File.read(fixture_file(path))
  end

  def json_fixture_file(path)
    JSON.parse(read_fixture_file(path))
  end
end

include FixtureFile
