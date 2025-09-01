require "test_helper"

describe PlayersController do
  it "gets index successfully" do
    get players_url
    _(response).must_be :successful?
  end

  it "gets new successfully" do
    get new_player_url
    _(response).must_be :successful?
  end

  it "gets edit successfully" do
    get edit_player_url(Player.first)
    _(response).must_be :successful?
  end
end
