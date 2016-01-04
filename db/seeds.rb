# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  languages = Language.create(
                          [
                              {
                                  name: 'English',
                                  code: 'en'
                              },
                              {
                                  name: 'Russian',
                                  code: 'ru'
                              },
                              {
                                  name: 'Hindi',
                                  code: 'hi'
                              }
                          ]
  )

  specializations = Specialization.create(
    [
        {
            name: 'General'
        },
        {
            name: 'Pediatry'
        },
        {
            name: 'Cardiology'
        },
        {
            name: 'Surgery'
        }
    ]
  )
