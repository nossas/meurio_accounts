# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Organization.create!(city: "Rio de Janeiro",
                     email_signature_html: 'Equipe do Meu Rio',
                     pdp_sender_email: "contato@meurio.org.br",
                     pdp_receiver_email: "contato@meurio.org.br",
                     slug: "riodejaneiro", name: "Meu Rio"
                    )
