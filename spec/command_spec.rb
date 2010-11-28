describe "command line tool" do

  describe "start" do

    before :each do
      @failed = false
      begin
        `pomodoro start`
      rescue Errno::ENOENT
        @failed = true
      end
    end

    it "exists" do
      @failed.should == false
    end

  end

  describe "stop" do

  end

end
