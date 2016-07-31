PostType = GraphQL::ObjectType.define do
  name "Post"
  description "A forum post"
  interfaces [NodeInterface]

  field :subject, !types.String
  field :content, !types.String

  field :comments do
    type -> { CommentConnectionType }

    argument :first, types.Int
    argument :last, types.Int
    argument :before, types.String
    argument :after, types.String

    resolve -> (obj, args, _ctx) {
      CommentConnection.new(obj.comments, first: args['first'], after: args['after'], last: args['last'], before: args['before'])
    }
  end
end
