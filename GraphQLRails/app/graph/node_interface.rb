NodeInterface = GraphQL::InterfaceType.define do
  name "Node"

  field :id do
    type !types.ID
    resolve -> (obj, _args, _ctx) { "#{obj.class.name}/#{obj.id}" }
  end
end
