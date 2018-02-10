# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Appquestion.create(
  name: 'question_artifact',
  text: 'Aritfact level for main specialisation',
  field_type: 'number',
  field_options: 'min=1 max=100 value=1',
  enabled: true,
  position: 0
)

Appquestion.create(
  name: 'question_offspec',
  text: 'What is your offspec gear/weapon like and are you confident in playing it?',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 1
)

Appquestion.create(
  name: 'question_alts',
  text: 'Do you have any alts you would also bring to the guild?',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 2
)

Appquestion.create(
  name: 'question_class',
  text: 'How do you stay up to date with your class? What sources do you use for theorycrafting?',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 3
)

Appquestion.create(
  name: 'question_whyyou',
  text: 'Why you? What makes you unique? What will you bring?',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 4
)

Appquestion.create(
  name: 'question_whyus',
  text: 'Why us? What makes you want to join us?',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 5
)

Appquestion.create(
  name: 'question_previousguilds',
  text: 'What are some previous guilds you have been apart of? why did you leave them? (if any)',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 6
)

Appquestion.create(
  name: 'question_anythingelse',
  text: 'Anything else you feel is relevent to your application',
  field_type: 'textarea',
  field_options: 'row=4 cols=50',
  enabled: true,
  position: 7
)
#<Appquestion id: nil, name: nil, text: nil, field_type: nil, field_options: nil, enabled: true, position: 0, created_at: nil, updated_at: nil>