require "socket" 

class ChatServer 

  def initialize(port) 
    @descriptors = Array::new 
    @serverSocket = TCPServer.new("", port) 
    @serverSocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1) 
    printf("Chatserver started on port %d\n", port) 
    @descriptors.push( @serverSocket ) 
  end # initialize 

  def run 
    
    loop do 
      res = select(@descriptors, nil, nil, nil) 

      if res != nil then 
        # Iterate through the tagged read descriptors 
        for sock in res[0] 
          # Received a connect to the server (listening) socket 
          if sock == @serverSocket then 
            accept_new_connection 
          else 
            # Received something on a client socket 
            if sock.eof? then 
              str = sprintf("Client left %s:%s\n", 
              sock.peeraddr[2], sock.peeraddr[1]) 
              broadcast_string( str, sock ) 
              sock.close 
              @descriptors.delete(sock) 
            else 
              str = sprintf("[%s|%s]: %s", 
              sock.peeraddr[2], sock.peeraddr[1], sock.gets()) 
              broadcast_string( str, sock ) 
            end 
          end 
        end 
      end 
    end
      
  end 

  private 
    def broadcast_string( str, omit_sock ) 
      @descriptors.each do |clisock| 
        if clisock != @serverSocket && clisock != omit_sock 
          clisock.write(str) 
        end 
      end 
      print(str)
    end 

    def accept_new_connection
      newsock = @serverSocket.accept 
      @descriptors.push(newsock) 
      
      newsock.write("You're connected to the Ruby chatserver\n") 
      str = sprintf("Client joined %s:%s\n", 
      
      newsock.peeraddr[2], newsock.peeraddr[1]) 
      broadcast_string(str, newsock)  
    end # accept_new_connection 

end #server

ChatServer.new(2626).run