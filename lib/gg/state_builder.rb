class GG::StateBuilder

  attr_reader :state

  def initialize(state, &block)
    @state = state
    self.instance_eval(&block)
  end

  def depth(value)
    state.max_depth = value
  end

end