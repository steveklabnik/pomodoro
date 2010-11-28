require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'noprocrast'
 
module Pomodoro
  class << self
    def start!
      Noprocrast.activate!
      @start_time = Time.now
      work_growl
    end
    def stop!
      Noprocrast.deactivate!
      break_growl
    end

    def work interval=5
      @start_time = Time.now if @start_time.nil?
      loop do
        elapsed_time = Time.now - @start_time
        if elapsed_time >= 1800 # 25 minutes * 60 seconds
          start!
        elsif elapsed_time >= 1500 # 30 minutes * 60 seconds
          stop!
        end
        break if interval == 0 #this lets us test one run-through
        sleep interval * 60
      end
    end

    def break_growl
      system 'growlnotify -w -n Pomodoro -m "You have 5 minutes." "BREAK TIME" -s'
    end

    def work_growl
      system 'growlnotify -w -n Pomodoro -m "This lasts 25 minutes." "WORK TIME" -s'
    end

  end
end

class PomodoroServer < Sinatra::Base
 
  get "/" do
    "GET BACK TO WORK"
  end
 
end

