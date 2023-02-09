# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Doctor.destroy_all
Patient.destroy_all
City.destroy_all
Appointment.destroy_all

nbcity = 20
nbdoctor = 20
nbpatient = 20
nbappointment = 20
array_specialty = ["Sexologie","Genoulogie","levlecoudologie","bobologie","Pedopsy","Stringologue","Slipologue","Arracheurdedents",]
doctors = []
patients = []
cities = []
specialties = []

nbcity.times do |x|
  city = City.create(name: Faker::Address.city)
  cities << city
  puts "Seeding City nb#{x}"
end

array_specialty.size.times do |x|
  specialty = Specialty.create(name: array_specialty[x])
  specialties << specialty
  puts "Seeding Specialty nb#{x}"
end

nbpatient.times do |x|
  patient = Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city_id: cities[rand(0..nbcity-1)].id)
    patients << patient
  puts "Seeding Patient nb#{x}"
end

nbdoctor.times do |x|
	doctor = Doctor.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    zip_code: rand(32000..35000),
    city: cities[rand(0..nbcity-1)])
    doctors << doctor
  puts "Seeding Doctor nb#{x}"
end

t1 = Time.parse("2019-10-23 14:40:34")
t2 = Time.parse("2021-01-01 00:00:00")
nbappointment.times do |x|
  appointment = Appointment.create(
    doctor_id: doctors[rand(0..nbdoctor-1)].id,
    patient_id: patients[rand(0..nbpatient-1)].id,
    city_id: cities[rand(0..nbcity-1)].id,
    date: rand(t1..t2))
  puts "Seeding Appointment nb#{x}"
end

nbdoctor.times do |x|
  doc_spe = DoctorSpecialty.create(
    doctor_id: doctors[x].id,
    specialty_id: specialties[rand(1..array_specialty.size-1)].id)
  puts "Seeding a specialty to Doctor nb#{x}"
end

