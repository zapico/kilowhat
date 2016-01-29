# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name:"hem")
Category.create(name:"lamps")
Conversion.create(unit: "hours", base_value:"5", name: "LED lampa", description: "", icon: "", category_id:2, slug:"LED")
Conversion.create(unit: "hours", base_value:"60", name: "Lampa", description: "", icon: "", category_id:2, slug:"Lampa")
Conversion.create(unit: "hours", base_value:"5", name: "LED lampa", description: "", icon: "", category_id:1, slug:"LED")
Conversion.create(unit: "hours", base_value:"60", name: "Lampa", description: "", icon: "", category_id:1, slug:"Lampa")