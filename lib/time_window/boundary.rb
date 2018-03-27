module TimeWindow
  class Boundary

    attr_accessor :at
    attr_accessor :index

    def initialize(list, condition)
      @list      = list
      @at        = list.first.time
      @index     = 0
      @max_index = list.length - 1
      @condition = condition
    end

    def step!(duration)
      @at      += duration
      @index   += 1 until at_time?(@at)

      return @index 
    end

    def at_end?
      @index == @max_index
    end

    private

      def at_time?(time)
        at_end? || @condition.call(@list, @index, time)
      end

  end
end
