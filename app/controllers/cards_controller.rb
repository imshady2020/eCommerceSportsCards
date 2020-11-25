class CardsController < ApplicationController
  
  def index
    @teams = Team.all().order(:name)
    if params[:search]
      @cards = Card.joins(:player, :team).where("players.name LIKE '#{params[:search]}%' AND teams.id = #{params[:choice]}").page(params[:page])
    else
      @cards = Card.all.page(params[:page])
    end
  end

  def new_cards
    @teams = Team.all().order(:name)
    if params[:search]
      @cards = Card.joins(:player, :team).where("players.name LIKE ? AND teams.id = ? AND cards.created_at > ?",
        "#{params[:search]}%", params[:choice], Date.today - 3).page(params[:page])
    else
      @cards = Card.all.where("created_at > ?", Date.today - 6).page(params[:page])
    end
  end

  def updated_cards
    @teams = Team.all().order(:name)
    if params[:search]
      @cards = Card.joins(:player, :team).where("players.name LIKE ? AND teams.id = ? AND cards.updated_at > ? AND cards.updated_at <> cards.created_at",
        "#{params[:search]}%", params[:choice], Date.today - 3).page(params[:page])
    else
      @cards = Card.all.where("updated_at > ? AND updated_at <> created_at", Date.today - 3).page(params[:page])
    end
  end

  def show
    @card = Card.find(params[:id])
  end

end