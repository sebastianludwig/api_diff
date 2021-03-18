module ApiDiff
  class Property
    attr_reader :name, :type

    def initialize(name:, type:, writable:, static:)
      @name = name
      @type = type
      @writable = writable
      @static = static
    end

    def is_writable?
      @writable
    end

    def is_static?
      @static
    end

    def hash
      to_s.hash
    end

    def eql?(other)
      to_s == other.to_s
    end

    def to_s
      result = []
      result << "static" if is_static?
      result << (is_writable? ? "var" : "let")
      result << "#{name}: #{type}"
      result.join(" ")
    end

    def <=>(other)
      # static at the bottom
      return 1 if is_static? and not other.is_static?
      return -1 if not is_static? and other.is_static?

      # sort by name
      name <=> other.name
    end
  end
end
