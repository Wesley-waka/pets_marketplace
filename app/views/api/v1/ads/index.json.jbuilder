json.array! @ads do |ad|
    json.partial! 'show', ad: ad
end