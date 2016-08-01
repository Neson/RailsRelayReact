PostConnectionType = GraphQL::ObjectType.define do
  name "PostConnection"

  field :pageInfo, -> { !PageInfoType }, property: :page_info
  field :edges, -> { types[PostEdgeType] }
end
