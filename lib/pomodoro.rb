require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'noprocrast'
 
module Pomodoro
  class << self
    def start!
      Noprocrast.activate!
      @start_time = Time.now
    end
    def stop!
      Noprocrast.deactivate!
    end

    def work interval=5
      loop do
        if Time.now - @start_time  >= 1500 # 25 minutes * 60 seconds
          stop!
        end
        break if interval == 0
        sleep interval * 60
      end
    end
  end
end

class PomodoroServer < Sinatra::Base
 
  get "/" do
    "GET BACK TO WORK"
  end
 
end

