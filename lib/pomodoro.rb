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
  end
end

class PomodoroServer < Sinatra::Base
 
  get "/" do
    "GET BACK TO WORK"
  end
 
end

