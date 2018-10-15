json.array! @categories do |category|
  json.partial! 'category.json.jbuilder', category: category
end
