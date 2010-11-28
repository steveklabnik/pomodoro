require 'pomodoro'
require 'noprocrast'

describe Pomodoro do

  describe "#start!" do
    
    it "uses noprocrast" do
      Noprocrast.should_receive(:activate!)
      Pomodoro.start!
    end

  end

  describe "#stop!" do
  end

end
