require "spec_helper"

RSpec.describe TimeWindow do
  it "has a version number" do
    expect(TimeWindow::VERSION).not_to be nil
  end

  it "initialize a window object" do
    time_window = TimeWindow.new([], window_size: 1.minute)
    expect(time_window).to be_a(TimeWindow::Slide)
  end
end
