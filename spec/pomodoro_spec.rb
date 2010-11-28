# I'm not sure why these don't work, since they're in the spec_helper...
require 'noprocrast'
require './lib/pomodoro'
require 'timecop'
require 'chronic'

describe Pomodoro do

  before :all do
    #all of these methods have ugly side effects, so let's just
    #redefine them as noops
    def Noprocrast.activate!
    end
    def Noprocrast.deactivate!
    end
    def Pomodoro.break_growl
    end
    def Pomodoro.work_growl
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

    it "growls" do
      Pomodoro.should_receive(:work_growl)
      Pomodoro.start!
    end

  end

  describe "#stop!" do

    it "uses noprocrast" do
      Noprocrast.should_receive(:deactivate!)
      Pomodoro.stop!
    end

    it "growls" do
      Pomodoro.should_receive(:break_growl)
      Pomodoro.stop!
    end

  end

  describe "#work" do

    it "doesn't call #stop! for the first 24 minutes" do
      Pomodoro.start!
      Pomodoro.should_not_receive(:stop!)
      Timecop.travel(Chronic.parse('24 minutes from now'))
      Pomodoro.work
      Timecop.return
    end

    it "calls #stop! after 25 minutes" do
      Pomodoro.start!
      Pomodoro.should_receive(:stop!)
      Timecop.travel(Chronic.parse('26 minutes from now'))
      Pomodoro.work
      Timecop.return
    end

    it "doesn't call #start! for the first 29 minutes" do
      Pomodoro.start!
      Pomodoro.should_not_receive(:start!)
      Timecop.travel(Chronic.parse('29 minutes from now'))
      Pomodoro.work
      Timecop.return
    end

    it "calls #start! after 30 minutes" do
      Pomodoro.start!
      Pomodoro.should_receive(:start!)
      Pomodoro.instance_variable_set(:@stopped, true)
      Timecop.travel(Chronic.parse('31 minutes from now'))
      Pomodoro.work
      Timecop.return
    end

    it "sets @start_time if it's not set" do
      Pomodoro.instance_variable_set(:@start_time, nil)
      Timecop.freeze do
        Pomodoro.work
        Pomodoro.instance_variable_get(:@start_time).should == Time.now
      end
    end

  end

end
