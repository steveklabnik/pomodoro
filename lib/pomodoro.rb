require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'noprocrast'
require 'terminal-notifier'
 
module Pomodoro
  class << self
    def start!
      Noprocrast.activate!
      @start_time = Time.now
      work_growl
      @stopped = false
    end
    def stop!
      Noprocrast.deactivate!
      break_growl
      @stopped = true
    end

    def work
      @start_time = Time.now if @start_time.nil?
      elapsed_time = Time.now - @start_time
      if elapsed_time >= 1800 && @stopped == true # 30 minutes * 60 seconds
        start!
      elsif elapsed_time >= 1500 && @stopped == false # 25 minutes * 60 seconds
        stop!
      end
    end

    def break_growl
      if (TerminalNotifier.available?) then
        TerminalNotifier.notify('You have 5 minutes.', :title => 'Pomodoro', :subtitle => 'BREAK TIME')
      else
        system 'growlnotify -w -n Pomodoro -m "You have 5 minutes." "BREAK TIME"'
      end
    end

    def work_growl
      if (TerminalNotifier.available?) then
        TerminalNotifier.notify('This lasts 25 minutes.', :title => 'Pomodoro', :subtitle => 'WORK TIME')
      else
        system 'growlnotify -w -n Pomodoro -m "This lasts 25 minutes." "WORK TIME"'
      end
    end

  end
end

class PomodoroServer < Sinatra::Base
  enable :sessions
  
 
  get "/" do
    session[:visits] ||= 0
    session[:visits] += 1
    "<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
    <style type='text/css'>
      /*<![CDATA[*/
        h1 {
          font-family: Verdana, Arial, sans-serif; 
          font-size: 96px;
          font-weight: bold;
          text-align: center;
          padding-top: 50px;
        }
        h2 {
          font-family: Verdana, Arial, sans-serif; 
          font-size: 72px;
          font-weight: bold;
          text-align: center;
        }
      /*]]>*/
    </style>
    
  </head>
  <body>
    <h1>GET BACK TO WORK!</h1>
    <h2>YOU'VE BEEN HERE #{session[:visits]} TIMES THIS BREAK!</h2>
  </body>
</html>"
  end
 
end

