json.array!(@horses) do |horse|
  json.extract! horse, :name, :sex, :year, :sire_id, :dam_id
  json.url horse_url(horse, format: :json)
end
