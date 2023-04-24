# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
i = 1
5.times do |i|
    user = User.create(email: "studentfaker#{i}@example.com", password: "password")
    user.add_role(:student)
    user.save
    puts "User Created"
    program = Program.create(code: "P#{i}", name:Faker::Educator.degree, description: "Sample Faker courses")
    # Create a student record that belongs to the user
    student = Student.create(user: user, program: program)
    puts "Student Saved"
    # Create a profile that polymorphs on the student
    profile = student.create_profile(
        name: Faker::Name.name,
        gender: Faker::Gender.binary_type,
        birthdate: Faker::Date.between(from: 30.years.ago, to: 18.years.ago),
        contact_number: Faker::PhoneNumber.cell_phone,
        address: Faker::Address.street_address,
        email: user.email)
puts "Student no #{i} created"
end

