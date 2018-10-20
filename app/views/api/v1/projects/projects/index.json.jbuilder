json.array! @projects do |project|
  json.partial! 'project.json.jbuilder', project: project
end
