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

User.create(
  email: 'andrew@disvelop.net',
  password: 'changeme',
  access_level: 2
)

User.create(
  email: 'ishyy@isogguild.com',
  password: 'changeme',
  access_level: 2
)

User.create(
  email: 'pharma@isogguild.com',
  password: 'changeme',
  access_level: 1
)

r = JSON.parse('{"mage":{"fire":true,"frost":true,"arcane":true},"monk":{"brewmaster":true,"mistweaver":true,"windwalker":true},"druid":{"feral":true,"balance":true,"guardian":true,"restoration":true},"rogue":{"outlaw":true,"subtlety":true,"assassination":true},"hunter":{"survival":true,"beastmastery":true,"marksmanship":true},"priest":{"holy":true,"shadow":true,"discipline":true},"shaman":{"elemental":true,"enhancement":true,"restoration":true},"paladin":{"holy":true,"protection":true,"retribution":true},"warlock":{"affliction":true,"demonology":true,"destruction":true},"warrior":{"arms":true,"fury":true,"protection":true},"deathknight":{"blood":true,"frost":true,"unholy":true},"demonhunter":{"havoc":true,"vengeance":true}}')
Setting.create(name: 'recruiting', settings: r)

s = JSON.parse('{"contents": "test post please ignore" }')
Setting.create(name: 'frontpage', settings: s)
