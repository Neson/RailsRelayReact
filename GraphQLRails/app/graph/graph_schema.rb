GraphSchema = GraphQL::Schema.new(
  query: QueryType,
  mutation: MutationType,
  max_depth: 8
)
