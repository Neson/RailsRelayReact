CommentConnectionType = GraphQL::ObjectType.define do
  name "CommentConnection"

  field :pageInfo, -> { !PageInfoType }, property: :page_info
  field :edges, -> { types[CommentEdgeType] }
end
