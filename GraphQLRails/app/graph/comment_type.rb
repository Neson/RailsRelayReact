CommentType = GraphQL::ObjectType.define do
  name "Comment"
  description "A reply to a post"
  interfaces [NodeInterface]

  field :content, !types.String

  field :post, !PostType
end
