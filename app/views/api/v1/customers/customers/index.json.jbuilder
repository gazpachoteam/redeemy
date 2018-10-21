json.array! @customers do |customer|
  json.partial! 'customer.json.jbuilder', customer: customer
end
