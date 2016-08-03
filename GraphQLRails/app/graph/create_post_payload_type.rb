CreatePostPayloadType = GraphQL::ObjectType.define do
  name "CreatePostPayload"

  field :clientMutationId, types.String, property: :client_mutation_id
  field :post, -> { PostType }
end
