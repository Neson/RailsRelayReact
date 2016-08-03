MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createPost do
    type -> { CreatePostPayloadType }

    argument :input, CreatePostInputType

    resolve -> (_obj, args, _ctx) {
      input = args[:input]
      post = Post.create!(subject: input[:subject], content: input[:content])
      CreatePostPayload.new(post: post, client_mutation_id: input[:clientMutationId])
    }
  end
end
