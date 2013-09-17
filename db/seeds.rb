# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
count = 0
File.open("../../dosprogs/rhorse/JASON.TXT","r") do |infile|
  infile.gets # skip first line
  while line = infile.gets.chomp! do

    count += 1
    
    horsenum	= line[0..7].to_i	# old ID
    name 	= line[8..42].rstrip   	# name
    sire 	= line[43..50].to_i    	# sire
    dam 	= line[51..58].to_i    	# dam
    trainer	= line[59..66]	    	# trainer
    year	= line[67..70].to_i    	# year
    sex		= line[71].downcase	# sex

    while count < horsenum
      Horse.create name: "*** was missing ***"
      count += 1
    end

    sire = nil if sire == 0
    dam = nil if dam == 1
    year = nil if year == 0
    name = "*** was blanks ***" if name == ""

    horse = Horse.create(
              name: name, year: year, sire_id: sire, dam_id: dam, sex: sex)
    if horse.id != horsenum.to_i
      puts "BAD: #{horse.id} != #{horsenum}"
      exit -999
    end

    puts "Processed #{count}" if count % 1000 == 0
  end
end
puts "Processed #{count}"
