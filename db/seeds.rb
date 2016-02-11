# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = Role.create(
    [
        {
            name: 'admin'
        },
        {
            name:'client'
        },
        {
            name: 'doctor'
        },
        {
            name: 'manager'
        }
    ]
)

  admin = User.create(
                  name: 'admin',
                  email: 'admin@gmail.com',
                  password: '12345678'
  )
  manager = User.create(
                  name: 'manager',
                  email: 'manager@gmail.com',
                  password: '12345678'
  )

  client = User.create(
                   name: 'client',
                   email: 'client@gmail.com',
                   password: '12345678'
  )

  # assign adming role to admin user
  adminAssignment = Assignment.create(user_id: '1', role_id:'1')
  managerAssignment = Assignment.create(user_id: '2', role_id:'4')
  clientAssignment = Assignment.create(user_id: '3', role_id: '2')

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
                              },
                              {
                                  name: 'Urdu',
                                  code: 'ur'
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
CallBack.create!(
    name: Faker::Name.name,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.cell_phone,
    language: 'English',
    email: Faker::Internet.email,
    specialization: 'general',
    message: Faker::Hipster.sentence,
    didAgree: true,
    code: '11'
)

# generate fake data just for visual purposes
  100.times do |call_back|
    CallBack.create!(
                name: Faker::Name.name,
                country: Faker::Address.country,
                phone: Faker::PhoneNumber.cell_phone,
                language: 'English',
                email: Faker::Internet.email,
                specialization: 'general',
                message: Faker::Hipster.sentence,
                didAgree: true,
                code: '123'
    )
  end

