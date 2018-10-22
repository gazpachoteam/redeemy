json.id redemption.id
json.customer do
  json.partial! 'api/v1/customers/customers/customer.json.jbuilder', customer: redemption.customer
end
json.project do
  json.partial! 'api/v1/projects/projects/project.json.jbuilder', project: redemption.project
end

json.points redemption.points
