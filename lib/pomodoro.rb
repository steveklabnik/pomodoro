module Pomodoro
  class << self
    def start!
      Noprocrast.activate!
    end

    def stop!
    end
  end
end
