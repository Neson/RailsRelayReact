PostType = GraphQL::ObjectType.define do
  name "Post"
  description "A forum post"
  interfaces [NodeInterface]

  field :subject, !types.String
  field :content, !types.String

  field :comments, -> { !types[!CommentType] }
end
