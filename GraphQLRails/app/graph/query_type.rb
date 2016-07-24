QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for the schema'

  field :node do
    type NodeInterface
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) {
      id_split = args['id'].split('-')
      class_name = id_split.first
      instance_id = id_split.last
      class_name.constantize.find(instance_id)
    }
  end

  field :post do
    type PostType
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) { Post.find(args['id'].split('/').last) }
  end

  field :comment do
    type CommentType
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) { Comment.find(args['id'].split('/').last) }
  end

  field :latestPost do
    type PostType
    resolve -> (_obj, _args, _ctx) { Post.last }
  end
end
