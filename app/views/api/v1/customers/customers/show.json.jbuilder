json.id @customer.id
json.name @customer.name
json.points @customer.nro_of_points
json.accounts do
  json.array! @customer.accounts do |account|
    json.partial! 'api/v1/accounts/account.json.jbuilder', account: account
  end
end
