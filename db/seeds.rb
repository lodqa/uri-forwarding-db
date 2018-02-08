# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Matcher.create([{
  name: 'http',
  uri_pattern: 'http://.+',
  url_replacement_pattern: 'http://example.com',
  priority: 0
},{
  name: 'wikipedia1',
  uri_pattern: 'http://www4.wiwiss.fu-berlin.de/diseasome/resource/(?<parent>\w+)/(?<entry>.+)',
  url_replacement_pattern: 'http://wikipedia.org/\k<parent>/\k<entry>',
  priority: 1
},{
  name: 'wikipedia2',
  uri_pattern: 'http://www4.wiwiss.fu-berlin.de/diseasome/resource/genes/(?<entry>[[:upper:]])',
  url_replacement_pattern: 'http://wikipedia.org/\k<entry>',
  priority: 2
}])
