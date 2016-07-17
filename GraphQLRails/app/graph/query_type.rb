QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for the schema'

  field :post do
    type PostType
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) { Post.find(args['id']) }
  end
end
