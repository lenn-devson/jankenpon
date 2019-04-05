# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
scissors = Element.create(title: 'Schere')
stone = Element.create(title: 'Stein')
paper = Element.create(title: 'Papier')
spock = Element.create(title: 'Spock')
lizard = Element.create(title: 'Echse')

Win.create(element_id: scissors.id, wins_against_id: paper.id )
Win.create(element_id: scissors.id, wins_against_id: lizard.id )

Win.create(element_id: stone.id, wins_against_id: scissors.id )
Win.create(element_id: stone.id, wins_against_id: lizard.id )

Win.create(element_id: paper.id, wins_against_id: stone.id )
Win.create(element_id: paper.id, wins_against_id: spock.id )

Win.create(element_id: lizard.id, wins_against_id: paper.id )
Win.create(element_id: lizard.id, wins_against_id: spock.id )

Win.create(element_id: spock.id, wins_against_id: stone.id )
Win.create(element_id: spock.id, wins_against_id: scissors.id )
