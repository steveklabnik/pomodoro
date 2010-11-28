module Pomodoro
  class << self
    def start!
      Noprocrast.activate!
    end

    def stop!
      Noprocrast.deactivate!
    end
  end
end
