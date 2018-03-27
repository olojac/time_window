# TimeWindow
Analyze windows of time in a time series. You can preform the following operations:

 - **Slide** a window of given length across your series
 - **Partion** your series into a given number of windows

## Installation
```ruby
gem 'time_window', :git => 'https://github.com/olojac/time_window.git'
```

## Usage
You need a collection of objects with that respond to *object.time*. The collection should also be sorted from oldest to newest.
```ruby
# your sorted collection of object with the attribute *#time*
list = [
  OpenStruct.new(time: 3.hours.ago, value: 1),
  OpenStruct.new(time: 2.hours.ago, value: 2),
  OpenStruct.new(time: 1.hour.ago,  value: 3),
]

# create a time series and slide a time window over it
TimeWindow.new(list, window_size: 1.hour).each do |items|
  items # your sliding time window
end
```

You can also access the times and indexes for the window

```ruby
TimeWindow.new(list, window_size: 1.hour).each do |items, times, indexes|
  items   # array of items in the window
  times   # array with start and end time of window
  indexes # range of the indexes for the items in the window
end
```

TimeWindow implements Enumerable so *#map*, *#to_a* and so on is also availible.

### Slide

*TimeWindow.slide* is the default operation and the same as TimeWindow.new.

You can also set the step_size (default is 1.second).

```ruby
TimeWindow.slide(list, window_size: 1.hour, step_size: 10.seconds).each do |items|
  items # your sliding time window
end
```

### Partition

*TimeWindow.partition* divieds your list to a given number for equally large windows. 

```ruby
TimeWindow.partition(list, window_count: 10).each do |items|
  items # your sliding time window
end
```


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

