class GameController < ApplicationController

  def setup

  end

  def init
    session[:game] = { bots: [] }
    params[:players].to_i.times do |i|
      session[:game][:bots] << { id: i+1, score: 0, element: {}, result: 'draw'}
    end
    session[:game][:player] = { element: {}, score: 0}
    session[:game][:rounds] = params[:rounds].to_i
    redirect_to play_path
  end

  def play
    @elements = Element.all
    @bots = session[:game]['bots']
    @player = session[:game]['player']
    @player_element = @player['element'].try(:[],'id')
    @rounds = session[:game]['rounds']
    render :play
  end

  def evaluate
    game = session[:game]
    player = game['player']
    bots = game['bots']
    player_element =  Element.find(params[:element_id])
    player_wins = player_element.wins.map(&:wins_against_id)
    player['element'] = player_element
    elements = Element.all
    bots.each_with_index do |bot, index|
      bot_element = elements[rand(elements.count)]
      bots[index]['element'] = bot_element
      if player_wins.include?(bot_element.id)
        player['score'] += 1
        bots[index]['result'] = 'won'
        bots[index]['score'] -= 1
      else
        if player_element.id == bot_element.id
          bots[index]['result'] = 'draw'
        else
          player['score'] -= 1
          bots[index]['score'] += 1
          bots[index]['result'] = 'lost'
        end
      end
    end
    game['rounds'] -= 1
    game['bots'] = bots
    game['player'] = player
    session[:game] = game
    
    if game['rounds'] > 0
      redirect_to play_path
    else
      flash[:notice] = "Spiel beendet mit #{player['score']} Punkten."
      redirect_to setup_path
    end
  end
end
