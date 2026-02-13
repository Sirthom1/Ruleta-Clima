class PlayersController < ApplicationController
    def index
        @players = Player.all
    end

    def search
        # VULNERABLE: SQL Injection - usando string interpolation directamente
        if params[:query].present?
            @players = Player.where("name LIKE '%#{params[:query]}%'")
        else
            @players = Player.all
        end
        render :index
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

    def edit
        @player = Player.find(params[:id])
    end

    def update
        @player = Player.find(params[:id])
        # VULNERABLE: Mass assignment - removí strong parameters
        if @player.update(params[:player])
            redirect_to players_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def admin_update
        # VULNERABLE: Sin autenticación ni autorización
        @player = Player.find(params[:id])
        @player.update(money: params[:money])
        redirect_to players_path
    end

    private

    def player_params
        params.expect(player: [ :name, :money ])
    end
end
