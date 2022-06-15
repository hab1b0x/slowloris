# slowloris
Slowloris is a Ruby port of the original Perl slowloris tool.

# Author 
Habib0x


# usage
ruby slowloris.rb <url> <socket>

where <socket> is the number of socket you want to specify by default the number of socket is 10


``` 
ruby slowloris.rb

      _____________
    ((             ))
     )) Slowloris ((
    ((             ))
      -------------


Slowloris is a tool that allows a client to simulate a slow HTTP connection to a server.
It is useful for testing and benchmarking servers.
This is Ruby port of the original Perl slowloris tool. Developed by Habib0x

usage: slowloris.rb [options] <URL>

TARGET SELECTION:
    <TARGETs>			Enter URL, hostnames, IP addresses.

HTTP OPTIONS:
    --user-agent, -u=AGENT	Identify as AGENT instead of 0.1


SOCKET OPTIONS:
    --sockets, -s=NUM			Use NUM sockets.
				 Default: 10.

PROXY:
    --proxy,			<hostname[:port]> Set proxy hostname and port.
				Default: :8080

OUTPUT:
    --verbose, -v			Print verbose output.

HELP:
    --help, -h				Display usage information.
    --version, -V			Display version information.

EXAMPLE USAGE:
    * Default Run
    slowloris.rb www.example.com

    * Define Number of Sockets
    slowloris.rb www.example.com -s 10
``` 

# Disclaimer 
Although many web servers nowadays have implemented some proper security measures to protect themselves against Slowloris attacks, this script can still make some severe damage to old or misconfigured web servers. Use it wisely and at your own responsibility!

# License 
feel free to clone it, improve it and share it independently as you wish. You are totaly welcome to contribute by creating a pull request as well.

Furthrmore, the code is licensed under the MIT License.
