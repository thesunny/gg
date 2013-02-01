class GG::State
  
  attr_reader :hash
  attr_accessor :max_depth, :current_depth
  
  def initialize(&block)
    @hash = {}
    @max_depth = 3
    @current_depth = 1
    GG::StateBuilder.new(self, &block) if block
  end
  
  def exists?(value)
    hash.key?(value.object_id)
  end
  
  def add(value)
    hash[value.object_id] = true
  end

  def too_deep?
    max_depth.nil? ? false : current_depth > max_depth
  end

  # go deeper into a structure
  def dive
    @current_depth += 1
  end

  # go out of a structure
  def surface
    @current_depth -= 1
  end

end