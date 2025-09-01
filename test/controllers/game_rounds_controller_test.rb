require "test_helper"

describe GameRoundsController do
  it "gets index successfully" do
    get game_rounds_url
    _(response).must_be :successful?
  end
end
