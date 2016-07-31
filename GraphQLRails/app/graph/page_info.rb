class PageInfo
  attr_accessor :has_next_page
  attr_accessor :has_previous_page
  attr_accessor :start_cursor
  attr_accessor :end_cursor

  def initialize(has_next_page:, has_previous_page:, start_cursor: nil, end_cursor: nil)
    self.has_next_page = has_next_page
    self.has_previous_page = has_previous_page
    self.start_cursor = start_cursor
    self.end_cursor = end_cursor
  end
end
