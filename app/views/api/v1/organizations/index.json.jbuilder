json.array! @organizations do |organization|
  json.partial! 'organization.json.jbuilder', organization: organization
end
