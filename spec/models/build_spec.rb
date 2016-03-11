require 'spec_helper'

describe Build do
  subject(:build){FactoryGirl.build(:build)}

  it do
    is_expected.to have_attributes(
      id: '608cb5cb-4468-44ca-b75c-7555f22cdf71',
      pull_request: be_a(PullRequest),
      slug: 'lintci/guinea_pig/6dbc62fe88432b6f9489a3d9f00dddf955a44c4e/608cb5cb-4468-44ca-b75c-7555f22cdf71',
      inspect: '<Build: 608cb5cb-4468-44ca-b75c-7555f22cdf71>'
    )
  end
end
