# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Admin::Category.delete_all
# (1..3).each do |i|
#   tmp = Admin::Category.new(name:"分类#{i}",level:0,weight:i)
#   tmp.code = tmp.level.to_s+tmp.weight.to_s
#   tmp.name = "--"*tmp.level+tmp.name
#   tmp.father_id = 0
#   tmp.save
#   (1..3).each do |j|
#     tmp = Admin::Category.new(name:"分类#{i}.#{j}",level:1,weight:j)
#     tmp.code = tmp.level.to_s+tmp.weight.to_s
#     tmp.name = "--"*tmp.level+tmp.name
#     tmp.father_id = i
#     tmp.save
#     (1..3).each do |k|
#       tmp = Admin::Category.new(name:"分类#{i}.#{j}.#{k}",level:2,weight:k)
#       tmp.code = tmp.level.to_s+tmp.weight.to_s
#       tmp.name = "--"*tmp.level+tmp.name
#       tmp.father_id = j
#       tmp.save
#     end
#   end
# end
