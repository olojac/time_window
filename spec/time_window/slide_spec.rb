require "spec_helper"

describe TimeWindow::Slide do

  it "handels a nil list" do
    list   = nil
    window = TimeWindow.new(list, window_size: 30.minutes)
    result = window.to_a

    expect(result).to eq([])
  end

  it "handles an empty list" do
    list   = []
    window = TimeWindow.new(list, window_size: 30.minutes)
    result = window.to_a

    expect(result).to eq([])
  end

  it "handels a one item list" do
    list   = [Message.new(time: Time.now, value: 1)]
    window = TimeWindow.new(list, window_size: 30.minutes)
    result = window.to_a

    expect(result).to eq([list])
  end

  it "returns the whole list on a too large window_size" do
    list   = [Message.new(time: 10.minutes.ago, value: 1), Message.new(time: 1.minute.ago, value: 1)]
    window = TimeWindow.new(list, window_size: 30.minutes)
    result = window.to_a

    expect(result).to eq([list])
  end

  it "is always a subset of the list" do
    list   = MessageGenerator.new(40.minutes.ago, Time.now, spacing: 1.minute..5.minutes, data: 1..10)
    window = TimeWindow.new(list, window_size: 30.minutes)
    
    expect(window.max.length).to be <= list.length
  end

  it "returns items if 1 (or less) parameters is provided" do
    list   = MessageGenerator.new(40.minutes.ago, Time.now, spacing: 1.minute..5.minutes, data: 1..10)
    window = TimeWindow.new(list, window_size: 30.minutes)

    result_array = window.to_a
    result_items = window.map { |items| items }

    expect(result_items.length).to eq(result_array.length)
    expect(result_items.flatten).to all(be_a(Message))
    expect(result_array.flatten).to all(be_a(Message))
  end

  it "returns items and time if 2 parameters is provided" do
    list   = MessageGenerator.new(40.minutes.ago, Time.now, spacing: 1.minute..5.minutes, data: 1..10)
    window = TimeWindow.new(list, window_size: 30.minutes)

    result_items = window.map { |items, _times| items }
    result_times = window.map { |_items, times| times }

    expect(result_items.length).to eq(result_times.length)
    expect(result_items.flatten).to all(be_a(Message))
    expect(result_times.flatten).to all(be_a(Time))
  end

  it "returns items, time and index if 3 parameters is provided" do
    list   = MessageGenerator.new(40.minutes.ago, Time.now, spacing: 1.minute..5.minutes, data: 1..10)
    window = TimeWindow.new(list, window_size: 30.minutes)

    result_items = window.map { |items, _times, _index| items }
    result_times = window.map { |_items, times, _index| times }
    result_index = window.map { |_items, _times, index| index }

    expect(result_items.length).to eq(result_times.length)
    expect(result_items.length).to eq(result_index.length)

    expect(result_items.flatten).to all(be_a(Message))
    expect(result_times.flatten).to all(be_a(Time))
    expect(result_index.flatten).to all(be_a(Range))
  end

  it "handles test #1" do
    m0 = Message.new(time: Time.new(2017, 1, 1, 0, 0),     value: 1)
    m1 = Message.new(time: Time.new(2017, 1, 1, 0, 0, 30), value: 2)
    m2 = Message.new(time: Time.new(2017, 1, 1, 0, 1, 21), value: 3)
    m3 = Message.new(time: Time.new(2017, 1, 1, 0, 1, 23), value: 2)
    m4 = Message.new(time: Time.new(2017, 1, 1, 0, 1, 28), value: 3)
    m5 = Message.new(time: Time.new(2017, 1, 1, 0, 1, 30), value: 4)
    m6 = Message.new(time: Time.new(2017, 1, 1, 0, 2, 23), value: 1)
    m7 = Message.new(time: Time.new(2017, 1, 1, 0, 2, 30), value: 3)
    m8 = Message.new(time: Time.new(2017, 1, 1, 0, 3),     value: 3)
    list = [m0, m1, m2, m3, m4, m5, m6, m7, m8]

    expected = [
      [m0, m1],             # 0:00 - 1:00
      [m1, m2, m3, m4, m5], # 0:30 - 1:30
      [m2, m3, m4, m5],     # 1:00 - 2:00
      [m5, m6, m7],         # 1:30 - 2:30
      [m6, m7, m8],         # 2:00 - 3:00
    ]

    window = TimeWindow.new(list, window_size: 1.minute, step_size: 30.seconds)
    result = window.to_a

    result.zip(expected).each do |r, e|
      expect(r).to eq(e)
    end
  end


  # it "test" do
  #   list   = MessageGenerator.new(4.days.ago, Time.now, spacing: 1.minute..5.minutes, data: 1..10)
  #   window = TimeWindow.new(list, window_size: 30.minutes)
  # end

end
