require "bundler/setup"
require "time_window"
require "benchmark/ips"
Dir[File.expand_path("../../spec/support/**/*.rb", __FILE__)].each { |f| require f }

list   = MessageGenerator.new(1.day.ago, Time.now, spacing: 1.minute..3.minutes)
window = TimeWindow.new(list, window_size: 1.hour, step_size: 1.minute)

Benchmark.ips do |x|
  x.report("each") { window.each { |items| items } }
  x.report("map")  { window.map  { |items| items } }
  
  x.compare!
end
