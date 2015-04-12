module OneWire
  class Base
    attr_reader :path

    def initialize path = nil
      @path = path
    end

    def name
      read_attr 'name'
    end

    def id
      read_attr 'id'
    end

    def w1_slave
      read_attr 'w1_slave'
    end

    alias_method :to_s, :w1_slave

    def value *args
      raise NotImplementedError
    end

    def last_value *args
      raise NotImplementedError
    end
    
    private

    def read_attr value
      File.read(File.join(@path.to_s, value)).chomp('')
    end
  end
end
