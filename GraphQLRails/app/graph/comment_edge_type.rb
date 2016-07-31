CommentEdgeType = GraphQL::ObjectType.define do
  name "CommentEdge"

  field :cursor, !types.String
  field :node, -> { CommentType }
end
