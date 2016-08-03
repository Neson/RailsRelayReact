class CreatePostPayload
  attr_reader :client_mutation_id
  attr_reader :post

  def initialize(post:, client_mutation_id: nil)
    @post = post
    @client_mutation_id = client_mutation_id
  end
end
