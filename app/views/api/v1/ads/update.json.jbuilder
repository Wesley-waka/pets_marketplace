json.status do
  json.code 200
  json.message 'Record was successfully updated'
end

json.partial! 'show', ad: @ad