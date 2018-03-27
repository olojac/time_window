module TimeWindow
  class Window
    include Enumerable

    def each(&block)
      return enum_for(:each) unless block_given?
      return [] if @list.empty?

      @content = nil
      yielder  = new_yielder(block.arity, content)

      until content.at_end?
        yield(*yielder.call)
        content.step!
      end
      yield(*yielder.call)
    end

    private

      def new_yielder(arity, content)
        case arity
        when -1, 0, 1
          -> { [content.items] }
        when 2
          -> { [content.items, content.at] }
        else
          -> { [content.items, content.at, content.index] }
        end
      end

      def limit_window_size(window_size, list)
        length = list_length(list)
        return length if window_size > length
        return window_size
      end

      def list_length(list)
        return 0 if list.first&.time.nil?
        TimeWindow.duration(from: list.first.time, to: list.last.time)
      end

      def calc_window_size(count, list)
        Rational(list_length(list), count)
      end
    
  end
end
