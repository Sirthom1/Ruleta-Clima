class PlayersController < ApplicationController
    def index
        @players = Player.all
    end

    def new
        @player = Player.new
    end

    def create
        @player = Player.new(player_params)
        @player.money = 10000

        if @player.save
            redirect_to players_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def player_params
        params.expect(player: [ :name])
    end
end
