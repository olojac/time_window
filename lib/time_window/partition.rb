require "time_window/window"
require "time_window/boundary"

module TimeWindow
  class Partition < Window

    def initialize(list, window_count:)
      @list        = list || []
      @window_size = calc_window_size(window_count, @list)
    end

    def content
      @content ||= Content.new(list: @list, window_size: @window_size)
    end

    class Content

      def initialize(list:, window_size:)
        remove_condition = ->(list, index, time) { list[index].time >= time }
        add_condition    = ->(list, index, time) { list[index + 1].time > time }
        @list            = list
        @left            = Boundary.new(@list, remove_condition)
        @right           = Boundary.new(@list, add_condition)
        @window_size     = window_size
        @right.step!(@window_size)
      end

      def step!
        @left.step!(@window_size)
        @right.step!(@window_size)
      end

      def at_end?
        @right.at_end?
      end

      def items
        @list[index]
      end

      def at
        [@left.at, @right.at]
      end

      def index
        @left.index..@right.index
      end
      
    end

  end
end
