PageInfoType = GraphQL::ObjectType.define do
  name "PageInfo"

  field :hasNextPage, !types.Boolean, property: :has_next_page
  field :hasPreviousPage, !types.Boolean, property: :has_previous_page
  field :startCursor, types.String, property: :start_cursor
  field :endCursor, types.String, property: :end_cursor
end
