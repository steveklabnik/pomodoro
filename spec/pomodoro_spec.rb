# I'm not sure why these don't work, since they're in the spec_helper...
require 'noprocrast'
require './lib/pomodoro'
require 'timecop'

describe Pomodoro do

  before :all do
    #rspec2 hates me, and won't stub properly
    #Noprocrast.stub(:activate!)
    #Noprocrast.stub(:deactivate!)
  end

  describe "#start!" do
    
    it "uses noprocrast" do
      Noprocrast.should_receive(:activate!)
      Pomodoro.start!
    end

    it "saves its start time" do
      Noprocrast.should_receive(:activate!)
      Timecop.freeze
      Pomodoro.start!
      Pomodoro.instance_variable_get(:@start_time).should == Time.now
    end

  end

  describe "#stop!" do

    it "uses noprocrast" do
      Noprocrast.should_receive(:deactivate!)
      Pomodoro.stop!
    end

  end

end
