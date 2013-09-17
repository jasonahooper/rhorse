# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
count = 0
File.open("../../dosprogs/rhorse/HORSEMST.TXT","r") do |infile|
  while line = infile.gets do
    horse	= line[0..7] 	    # ID
    name 	= line[8..42] 	    # name
    sire 	= line[43..50]	    # sire
    dam 	= line[51..58]	    # dam
    trainer	= line[59..66]	    # trainer
    year	= line[67..70]	    # trainer
    sex		= line[71].downcase	# sex

    sire = sire.to_i + 1
    sire = nil if sire == 1

    dam = dam.to_i + 1    
    dam = nil if dam == 2

    year = nil if year.to_i == 0

    Horse.create(name: name, year: year.to_i, sire_id: sire, dam_id: dam, sex: sex)

    count += 1
    puts "Processed #{count}" if count % 1000 == 0
  end
end
puts "Processed #{count}"
