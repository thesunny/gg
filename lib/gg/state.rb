class GG::State
  
  attr_reader :hash
  
  def initialize
    @hash = {}
    @depth = 2
  end
  
  def exists?(value)
    hash.key?(value.object_id)
  end
  
  def add(value)
    hash[value.object_id] = true
  end
  
  def depth(value=nil)
    if value.nil?
      @depth
    else
      @depth = depth
    end
  end
  
  
  # SHOW_LIMIT = 15
#   
  # def initialize
    # @show_count = 0
    # super
  # end
#   
  # attr_accessor :show_count
#   
  # def inc
    # @show_count += 1
  # end
#   
  # def continue?
    # @show_count <= SHOW_LIMIT
  # end
  
end