class MessageGenerator < Array

  def initialize(start_time, end_time, spacing: 5.minutes..1.hour, data: 2..6)

    time     = start_time
    messages = [message(time, data)]

    while time <= end_time do
      messages << message(time, data)
      time     += rand(spacing)
    end

    last = messages.last
    unless last.time == end_time
      messages << message(end_time, last.value..last.value)
    end

    super(messages)
  end

  private

    def message(time, data)
      Message.new(time: time.to_time, value: rand(data))
    end

end