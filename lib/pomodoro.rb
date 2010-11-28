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
      system 'growlnotify -w -n Pomodoro -m "You have 5 minutes." "BREAK TIME"'
    end

    def work_growl
      system 'growlnotify -w -n Pomodoro -m "This lasts 25 minutes." "WORK TIME"'
    end

  end
end

class PomodoroServer < Sinatra::Base
 
  get "/" do
    "GET BACK TO WORK"
  end
 
end

