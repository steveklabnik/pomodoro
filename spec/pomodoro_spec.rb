# I'm not sure why these don't work, since they're in the spec_helper...
require 'noprocrast'
require './lib/pomodoro'
require 'timecop'
require 'chronic'

describe Pomodoro do

  before :all do
    def Noprocrast.activate!
    end
    def Noprocrast.deactivate!
    end
  end

  describe "#start!" do
    
    it "uses noprocrast" do
      Noprocrast.should_receive(:activate!)
      Pomodoro.start!
    end

    it "saves its start time" do
      Timecop.freeze do
        Pomodoro.start!
        Pomodoro.instance_variable_get(:@start_time).should == Time.now
      end
    end

  end

  describe "#stop!" do

    it "uses noprocrast" do
      Noprocrast.should_receive(:deactivate!)
      Pomodoro.stop!
    end

  end

  describe "#work" do

    it "doesn't call #stop for the first 24 minutes" do
      Pomodoro.start!
      Pomodoro.should_not_receive(:stop!)
      Timecop.travel(Chronic.parse('24 minutes from now'))
      Pomodoro.work(0)
      Timecop.return
    end

    it "calls #stop! after 25 minutes" do
      Pomodoro.start!
      Pomodoro.should_receive(:stop!)
      Timecop.travel(Chronic.parse('26 minutes from now'))
      Pomodoro.work(0)
      Timecop.return
    end
  end

end
