json.status do
  json.code 200
  json.message 'Record was successfully created'
end

json.partial! 'show', profile: @profile