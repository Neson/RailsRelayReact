class Edge
  attr_accessor :node
  attr_accessor :cursor

  def initialize(node:, cursor:)
    self.node = node
    self.cursor = cursor
  end
end
