require "time_window/slide"
require "time_window/partition"
require "active_support/core_ext/numeric/time.rb"

module TimeWindow
  extend self

  def new(*args)
    slide(*args)
  end

  def slide(*args)
    Slide.new(*args)
  end

  def partition(*args)
    Partition.new(*args)
  end

  # def contiguous(*args)
  #   Contiguous.new(*args)
  # end

  def duration(from:, to:)
    to.to_r - from.to_r
  end

end
