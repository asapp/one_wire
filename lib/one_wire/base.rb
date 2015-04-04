module OneWire
  class Base
    attr_reader :path
    attr_accessor :force

    def initialize path = nil
      @path = path
      w1_slave(true)
      name(true)
      self
    end

    def name force = false
      return @name unless force || @force
      @name = File.read(File.join(@path, 'name')).chomp
    end

    alias_method :id, :name

    def w1_slave force = false
      return @w1_slave unless force || @force
      @w1_slave = File.read(File.join(path, 'w1_slave')).chomp
    end

    alias_method :to_s, :w1_slave

    def value *args
      raise NotImplementedError
    end

    def last_value *args
      raise NotImplementedError
    end

    def watch tight, &block
      OneWire.watch self, tight, &block
    end
  end
end
