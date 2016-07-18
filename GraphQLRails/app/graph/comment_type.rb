CommentType = GraphQL::ObjectType.define do
  name "Comment"
  description "A reply to a post"

  field :id, !types.ID
  field :content, !types.String

  field :post, !PostType
end
