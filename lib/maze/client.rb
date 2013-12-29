require "maze/client/version"

module Maze
  require 'socket'

  class Client
    def initialize(hostname = 'localhost', port = 9999, player_name)
      @hostname = hostname
      @port = port
      @name = player_name
      @socket = nil
    end

    def connect
      @socket = TCPSocket.open(@hostname, @port)
      puts @socket.gets.chop
      @socket.puts '{"playerName" : "' + @name + '"}'
    end
  end
end
