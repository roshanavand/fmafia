class Player
  def initialize(name, is_citizen=true)
    @name = name
    @is_citizen = is_citizen
  end

  def to_s
    @name
  end

  def is_citizen?
    @is_citizen
  end
end

class MafiaGame
  def initialize(citizens, mafia)
    @players = []

    for player in citizens do
      @players.push Player.new(player, true)
    end

    for player in mafia do
      @players.push Player.new(player, false)
    end

    @is_day = true
  end

  def play_day
    player = @players.sample
    @players.delete(player)
    puts "Day: #{player} got killed"
  end

  def play_night
    player = @players.select(&:is_citizen?).sample
    if player
      @players.delete(player)
      puts "Night: #{player} got killed"
    end
  end

  def check_winner
    citizen_count = @players.select(&:is_citizen?).count
    mafia_count = @players.reject(&:is_citizen?).count

    winner = if mafia_count >= citizen_count
               "Mafia"
             elsif mafia_count == 0
               "Citizens"
             end
    puts "> winner is #{winner}" if winner
    winner
  end

  def play
    while true
      winner = check_winner
      return winner if winner
      if @is_day
        play_day
      else
        play_night
      end
      @is_day = !@is_day
    end
  end

  def self.run
    citizens = %W(foo bar baz)
    mafia = %W(qux)

    mafia_wins = 0

    rounds = gets.to_i
    (1..rounds).each do |round|
      winner = MafiaGame.new(citizens, mafia).play
      mafia_wins += 1 if winner == 'Mafia'
    end

    if mafia_wins > (rounds/2)
      puts "Mafia is winner!"
    elsif mafia_wins == (rounds/2)
      puts "It's a tie!"
    else
      puts "citizens won!"
    end
  end
end
