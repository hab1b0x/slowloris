#!/usr/bin/ruby 
#
# Slowloris is a tool that allows a client to simulate a slow HTTP connection to a server.
# It is useful for testing and benchmarking servers.
#
# Slowloris is a Ruby port of the original Perl slowloris tool.
#
# Slowloris is copyright (c) 2009 by Jonathan Swartz.
#
# Slowloris is released under the terms of the MIT license.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require './lib/slowloris'
require 'socket'

#
# Command Line usage information and help
#

def usage
    puts red(Slowloris::BANNER)

    puts(<<-EOT)
Slowloris is a tool that allows a client to simulate a slow HTTP connection to a server.
It is useful for testing and benchmarking servers.
This is Ruby port of the original Perl slowloris tool. Developed by Habib0x

usage: slowloris.rb [options] <URL>

TARGET SELECTION:
    <TARGETs>\t\t\tEnter URL, hostnames, IP addresses.

HTTP OPTIONS:
    --user-agent, -u=AGENT\tIdentify as AGENT instead of #{Slowloris::VERSION}


SOCKET OPTIONS:
    --sockets, -s=NUM\t\t\tUse NUM sockets.
\t\t\t\t Default: #{$SOCKET}.

PROXY:
    --proxy,\t\t\t<hostname[:port]> Set proxy hostname and port. 
\t\t\t\tDefault: #{$PROXY_HOST}:#{$PROXY_PORT}

OUTPUT: 
    --verbose, -v\t\t\tPrint verbose output.

HELP:
    --help, -h\t\t\t\tDisplay usage information.
    --version, -V\t\t\tDisplay version information.

EXAMPLE USAGE:
    * Default Run
    slowloris.rb www.example.com
    
    * Define Number of Sockets
    slowloris.rb www.example.com -s 10 

EOT
end

if ARGV.empty?
    usage
    exit
end

# arguments
opts = GetoptLong.new(
    [ '-h', '--help', GetoptLong::NO_ARGUMENT ],
    [ '-v', '--verbose', GetoptLong::NO_ARGUMENT ],
    [ '-s', '--sockets', GetoptLong::REQUIRED_ARGUMENT ],
    [ '-a', '--user-agent', GetoptLong::REQUIRED_ARGUMENT ],
    [ '-p', '--proxy', GetoptLong::REQUIRED_ARGUMENT ],
    [ '-u', '--url', GetoptLong::NO_ARGUMENT ],
    [ '--version', GetoptLong::NO_ARGUMENT ]
)

begin
    opts.each do |opt, arg|
        case opt
            when '-h','--help'
                usage
                exit
            when '--version'
                puts red(Slowloris::BANNER)
                exit
            when '-v','--verbose'
                $VERBOSE = 1
            when '-s','--sockets'
                $SOCKET = true
                $SOCKET = arg
            when '-u','--user-agent'
                $USER_AGENT = arg
            when '-p', '--proxy'
                $PROXY = false
                $PROXY_HOST, $PROXY_PORT = arg.split(':')
            when '-u','--url'
                $URL = true
        end
    end
rescue GetoptLong::InvalidOption
    usage
    exit
end


main()
    