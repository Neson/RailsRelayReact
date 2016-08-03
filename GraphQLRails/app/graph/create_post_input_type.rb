CreatePostInputType = GraphQL::InputObjectType.define do
  name "CreatePostInput"

  input_field :clientMutationId, types.String
  input_field :subject, !types.String
  input_field :content, !types.String
end
