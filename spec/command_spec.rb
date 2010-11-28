describe "command line tool" do

  it "exists" do
    failed = false
    begin
      `pomodoro`
    rescue Errno::ENOENT
      fail
    end
  end

  describe "start" do

    # this doesn't work, for some reason. I think it's because
    # the file reloads the gem, maybe? Not sure. Sucks, though.
    #it "should delegate to Pomodoro#start" do
    #  Pomodoro.should_receive(:start)
    #  `./bin/pomodoro start`
    #end

  end

  describe "stop" do

  end

end
