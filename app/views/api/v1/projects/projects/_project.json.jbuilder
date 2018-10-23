json.id project.id
json.name project.name
json.description project.description
json.organization do
  json.partial! 'api/v1/organizations/organization.json.jbuilder', organization: project.organization
end
json.categories do
  json.array! project.categories do |category|
    json.partial! 'api/v1/categories/category.json.jbuilder', category: category
  end
end
