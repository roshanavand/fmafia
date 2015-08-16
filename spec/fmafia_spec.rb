require './fmafia.rb'

describe MafiaGame do

  it 'makes the citizens winner when there is no mafia left' do
    game = MafiaGame.new ['foo'], []
    expect(game.check_winner).to eq('Citizens')
  end

  it 'makes the mafia winner when there is no citizens left' do
    game = MafiaGame.new [], ['foo']
    expect(game.check_winner).to eq('Mafia')
  end

end
