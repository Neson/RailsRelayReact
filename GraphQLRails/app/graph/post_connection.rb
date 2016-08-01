class PostConnection
  attr_accessor :first
  attr_accessor :after
  attr_accessor :last
  attr_accessor :before
  attr_accessor :has_next_page
  attr_accessor :has_previous_page

  def initialize(posts_collection, first: nil, after: nil, last: nil, before: nil)
    @posts_collection = posts_collection
    @first = first
    @after = after
    @last = last
    @before = before
    @has_next_page = false
    @has_previous_page = false
  end

  def posts
    @posts ||= posts_to_return(@posts_collection, before: before, after: after, first: first, last: last)
  end

  def edges
    @edges ||= posts.map { |post| Edge.new(node: post, cursor: post.id) }
  end

  def page_info
    PageInfo.new(has_next_page: has_next_page, has_previous_page: has_previous_page, start_cursor: edges.first.try(:cursor), end_cursor: edges.last.try(:cursor))
  end

  private

  # Same logic as "EdgesToReturn" in the Relay specification
  def posts_to_return(posts, before: nil, after: nil, first: nil, last: nil, order: { created_at: :asc, id: :asc })
    posts = reorder_posts(posts, order: order)
    posts = apply_cursors_to_posts(posts, before: before, after: after, order: order)

    if first.present?
      fail '"first" should not be less then 0' if first < 0
      before_limit_posts_count = posts.count
      posts = posts.limit(first)
      after_limit_posts_count = posts.count

      self.has_next_page = true if before_limit_posts_count > after_limit_posts_count
    end

    if last.present?
      fail '"last" should not be less then 0' if last < 0
      before_offset_posts_count = posts.count
      posts = posts.offset(posts.count - last)
      after_offset_posts_count = posts.count

      self.has_previous_page = true if before_offset_posts_count > after_offset_posts_count
    end

    posts
  end

  # Same logic as "ApplyCursorsToEdges" in the Relay specification
  def apply_cursors_to_posts(posts, order:, before: nil, after: nil)
    if after.present?
      after_post = posts.find(after)

      # We know the order, so we can tell the database to remove all elements of
      # edges before and including `after_post` using the `WHERE` condition

      # `scope_condition` will be something like "created_at > ? AND id > ?"
      scope_condition = order.map { |column_name, direction| "#{column_name} #{direction.to_sym == :asc ? '>' : '<'} ?" }.join(' AND ')
      scope_condition_values = order.map { |column_name, _direction| after_post.try(column_name) }

      posts = posts.where(scope_condition, *scope_condition_values)
    end

    if before.present?
      # Same as `if after.present?`
      before_post = posts.find(before)
      scope_condition = order.map { |column_name, direction| "#{column_name} #{direction.to_sym == :asc ? '<' : '>'} ?" }.join(' AND ')
      scope_condition_values = order.map { |column_name, _direction| before_post.try(column_name) }
      posts = posts.where(scope_condition, *scope_condition_values)
    end

    posts
  end

  def reorder_posts(posts, order:)
    posts.reorder(order)
  end
end
