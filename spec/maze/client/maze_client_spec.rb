require_relative '../../../lib/maze/client/maze_client'

describe MazeClient do

  it 'can connect to a server' do
    socket = double('socket')
    maze_client = MazeClient.new('Name')
    allow(socket).to receive(:gets).and_return(double(:chop => '{"operation":"PLAYER_NAME"}'))
    expect(socket).to receive(:puts) { '{"playerName": "Name"}' }
    TCPSocket.stub(:open).with('localhost', 9999).and_return(socket)
    maze_client.connect
  end

  context 'client is connected' do
    before do
      @socket = double('socket')
      @maze_client = MazeClient.new('Name')
      allow(@socket).to receive(:gets).and_return(double(:chop => '{"operation":"PLAYER_NAME"}'))
      expect(@socket).to receive(:puts) { '{"playerName": "Name"}' }
      TCPSocket.stub(:open).with('localhost', 9999).and_return(@socket)
      @maze_client.connect
    end

    it 'can move top' do
      expect(@socket).to receive(:puts) { '{"move": "top"}' }
      @maze_client.move_top
    end

    it 'can move bottom' do
      expect(@socket).to receive(:puts) { '{"move": "bottom"}' }
      @maze_client.move_bottom
    end

    it 'can move left' do
      expect(@socket).to receive(:puts) { '{"move": "left"}' }
      @maze_client.move_left
    end

    it 'can move right' do
      expect(@socket).to receive(:puts) { '{"move": "right"}' }
      @maze_client.move_right
    end
  end

end