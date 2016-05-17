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
                  email: 'admin@gmail.com',
                  password: '12345678'
  )
  manager = User.create(
                  email: 'manager@gmail.com',
                  password: '12345678'
  )
  client_user = User.create(
                  email: 'client@gmail.com',
                  password: '12345678'
  )
  doctor_user = User.create(
                  email: 'doctor@gmail.com',
                  password: '12345678'
  )

  manager = Manager.create(
    user_id: 2
  )

  client = Client.create(
    user_id: 3,
    name: 'Yerassyl Diyas',
    country: 'Kazakhstan',
    phone: '877759798908',
    language: 'Kazakh'
  )

  doctor = Doctor.create(
                     email: 'doctor@gmail.com',
                     name:'Doctor Haus',
                     phone_number: '2423423423',
                     address: 'Kabanbay Batyr ave, 53',
                     user_id: 4
  )


    # assign adming role to admin user
  adminAssignment = Assignment.create(user_id: '1', role_id:'1')
  managerAssignment = Assignment.create(user_id: '2', role_id:'4')
  clientAssignment = Assignment.create(user_id: '3', role_id:'2')
  doctorAssignment = Assignment.create(user_id:'4', role_id:'3')

  mainPool = Pool.create(name: 'Main') # id =1
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
    name: 'Yerassyl Diyas',
    country: 'Kazakhstan',
    phone: '87775979808',
    language: 'English',
    email: 'erasildias@gmail.com',
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

# create patient
10.times do |patient|
  Patient.create(
    firstname: Faker::Name.first_name,
    middlename: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    birthday: Faker::Date.between(100.day.ago, Date.today),
    maritial_status: 'not-married',
    gender: true,
    email: Faker::Internet.email,
    telephone: Faker::PhoneNumber.phone_number,
    cellphone: Faker::PhoneNumber.cell_phone,
    emergency_person: Faker::StarWars.character,
    emergency_person_phone: Faker::PhoneNumber.phone_number,
    client_id: 1
  )
end

# create fake medical situations
40.times do |medical_situation|
  MedicalSituation.create(
    reason: Faker::Lorem.paragraph,
    patient_id: Faker::Number.between(1,10),
    doctor_id: nil,
    pool_id: 1,
    paid: false,
    price: nil,
    inPool: false
  )
end

40.times do |medical_situation|
  MedicalSituation.create(
      reason: Faker::Lorem.paragraph,
      patient_id: Faker::Number.between(1,10),
      doctor_id: nil,
      pool_id: 1,
      paid: false,
      price: Faker::Number.between(1000,7000),
      inPool: true
  )
end