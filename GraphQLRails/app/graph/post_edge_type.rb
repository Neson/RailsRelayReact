PostEdgeType = GraphQL::ObjectType.define do
  name "PostEdge"

  field :cursor, !types.String
  field :node, -> { PostType }
end
