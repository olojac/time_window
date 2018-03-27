class Message

  attr_accessor :time
  attr_accessor :value

  def initialize(time:, value:)
    @time = time
    @value = value
  end

  def <=>(other)
    self.time <=> other.time
  end

end