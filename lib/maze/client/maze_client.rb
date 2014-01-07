require 'socket'
require 'json'

class MazeClient
  attr_reader :next_moves, :player_moves

  def initialize(hostname = 'localhost', port = 9999, player_name)
    @hostname = hostname
    @port = port
    @name = player_name
    @socket = nil
    @next_moves = nil
    @player_moves = nil
  end

  def connect
    @socket = TCPSocket.open(@hostname, @port)
    puts @socket.gets.chop
    @socket.puts '{"playerName" : "' + @name + '"}'
    parse_response
  end

  def say_goodbye
    @socket.puts 'Goodbye'
  end

  def game_over?
    @player_moves != nil
  end

  def move_top
    @socket.puts '{"move" : "top"}'
    parse_response
  end

  def move_bottom
    @socket.puts '{"move" : "bottom"}'
    parse_response
  end

  def move_left
    @socket.puts '{"move" : "left"}'
    parse_response
  end

  def move_right
    @socket.puts '{"move" : "right"}'
    parse_response
  end

  private
  def parse_response
    response = JSON.parse(@socket.gets.chop)
    operation = response['operation']
    case operation
      when 'NEXT_MOVE'
        @next_moves = response['data']
        @player_moves = nil
      when 'PLAYER_MOVES'
        @player_moves = response['data']
        @next_moves = nil
      else
        @next_moves = nil
        @player_moves = nil
    end
  end
end