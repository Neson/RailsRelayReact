class CommentConnection
  attr_accessor :first
  attr_accessor :after
  attr_accessor :last
  attr_accessor :before
  attr_accessor :has_next_page
  attr_accessor :has_previous_page

  def initialize(comments_collection, first: nil, after: nil, last: nil, before: nil)
    @comments_collection = comments_collection
    @first = first
    @after = after
    @last = last
    @before = before
    @has_next_page = false
    @has_previous_page = false
  end

  def comments
    @comments ||= comments_to_return(@comments_collection, before: before, after: after, first: first, last: last)
  end

  def edges
    @edges ||= comments.map { |comment| Edge.new(node: comment, cursor: comment.id) }
  end

  def page_info
    PageInfo.new(has_next_page: has_next_page, has_previous_page: has_previous_page, start_cursor: edges.first.try(:cursor), end_cursor: edges.last.try(:cursor))
  end

  private

  # Same logic as "EdgesToReturn" in the Relay specification
  def comments_to_return(comments, before: nil, after: nil, first: nil, last: nil, order: { created_at: :asc, id: :asc })
    comments = reorder_comments(comments, order: order)
    comments = apply_cursors_to_comments(comments, before: before, after: after, order: order)

    if first.present?
      fail '"first" should not be less then 0' if first < 0
      before_limit_comments_count = comments.count
      comments = comments.limit(first)
      after_limit_comments_count = comments.count

      self.has_next_page = true if before_limit_comments_count > after_limit_comments_count
    end

    if last.present?
      fail '"last" should not be less then 0' if last < 0
      before_offset_comments_count = comments.count
      comments = comments.offset(comments.count - last)
      after_offset_comments_count = comments.count

      self.has_previous_page = true if before_offset_comments_count > after_offset_comments_count
    end

    comments
  end

  # Same logic as "ApplyCursorsToEdges" in the Relay specification
  def apply_cursors_to_comments(comments, order:, before: nil, after: nil)
    if after.present?
      after_comment = comments.find(after)

      # We know the order, so we can tell the database to remove all elements of
      # edges before and including `after_comment` using the `WHERE` condition

      # `scope_condition` will be something like "created_at > ? AND id > ?"
      scope_condition = order.map { |column_name, direction| "#{column_name} #{direction.to_sym == :asc ? '>' : '<'} ?" }.join(' AND ')
      scope_condition_values = order.map { |column_name, _direction| after_comment.try(column_name) }

      comments = comments.where(scope_condition, *scope_condition_values)
    end

    if before.present?
      # Same as `if after.present?`
      before_comment = comments.find(before)
      scope_condition = order.map { |column_name, direction| "#{column_name} #{direction.to_sym == :asc ? '<' : '>'} ?" }.join(' AND ')
      scope_condition_values = order.map { |column_name, _direction| before_comment.try(column_name) }
      comments = comments.where(scope_condition, *scope_condition_values)
    end

    comments
  end

  def reorder_comments(comments, order:)
    comments.reorder(order)
  end
end
