# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting all models..."

Author.destroy_all
Category.destroy_all
Book.destroy_all

puts "Creating authors..."

goggins = Author.create(
  first_name: 'David',
  last_name: 'Goggins',
)

jurek = Author.create(
  first_name: 'Scott',
  last_name: 'Jurek'
)

friedman = Author.create(
  first_name: 'Steve',
  last_name: 'Friedman'
)

braun = Author.create(
  first_name: 'Adam',
  last_name: 'Braun'
)

starrett = Author.create(
  first_name: 'Kelly',
  last_name: 'Starrett'
)

cordoza = Author.create(
  first_name: 'Glen',
  last_name: 'Cordoza'
)

puts "Creating categories..."

inspiration = Category.create(
  name: 'Inspiration'
)

motivation = Category.create(
  name: 'Motivation'
)

mobility = Category.create(
  name: 'Mobility'
)

flexibility = Category.create(
  name: 'Flexibility'
)

strength = Category.create(
  name: 'Strength'
)

running = Category.create(
  name: 'Running'
)

biography = Category.create(
  name: 'Biography'
)

puts "Creating books and associations..."

book1 = Book.create(
  title: "Can't Hurt Me",
  description: "For David Goggins, childhood was a nightmare -- poverty, prejudice, and physical abuse colored his days and haunted his nights. But through self-discipline, mental toughness, and hard work, Goggins transformed himself from a depressed, overweight young man with no future into a U.S. Armed Forces icon and one of the world's top endurance athletes. The only man in history to complete elite training as a Navy SEAL, Army Ranger, and Air Force Tactical Air Controller, he went on to set records in numerous endurance events, inspiring Outside magazine to name him \"The Fittest (Real) Man in America.\"",
  year_published: 2018,
  fiction: false,
)

BookAuthor.create(
  book: book1,
  author: goggins
)

BookCategory.create(
  book: book1,
  category: inspiration
)

BookCategory.create(
  book: book1,
  category: motivation
)

BookCategory.create(
  book: book1,
  category: running
)

BookCategory.create(
  book: book1,
  category: biography
)

book2 = Book.create(
  title: "Eat and Run: My Unlikely Journey to Ultramarathon Greatness",
  description: "For nearly two decades, Scott Jurek has been a dominant force—and darling—in the grueling and growing sport of ultrarunning. Until recently he held the American 24-hour record and he was one of the elite runners profiled in the runaway bestseller Born to Run.

In Eat and Run, Jurek opens up about his life and career as a champion athlete with a plant-based diet and inspires runners at every level. From his Midwestern childhood hunting, fishing, and cooking for his meat-and-potatoes family to his slow transition to ultrarunning and veganism, Scott’s story shows the power of an iron will and blows apart the stereotypes of what athletes should eat to fuel optimal performance. Full of stories of competition as well as science and practical advice—including his own recipes—Eat and Run will motivate readers and expand their food horizons.",
  year_published: 2012,
  fiction: false,
)

BookAuthor.create(
  book: book2,
  author: jurek
)

BookAuthor.create(
  book: book2,
  author: friedman
)

BookCategory.create(
  book: book2,
  category: biography
)

BookCategory.create(
  book: book2,
  category: running
)

book3 = Book.create(
  title: "The Promise of a Pencil: How an Ordinary Person Can Create Extraordinary Change",
  description: "The riveting story of how a young man turned $25 into more than 200 schools around the world and the guiding steps anyone can take to lead a successful and significant life.

Adam Braun began working summers at hedge funds when he was just sixteen years old, sprinting down the path to a successful Wall Street career. But while traveling he met a young boy begging on the streets of India, who after being asked what he wanted most in the world, simply answered, “A pencil.” This small request led to a staggering series of events that took Braun backpacking through dozens of countries before eventually leaving one of the world’s most prestigious jobs to found Pencils of Promise, the organization he started with just $25 that has since built more than 200 schools around the world.",
  year_published: 2014,
  fiction: false,
)

BookAuthor.create(
  book: book3,
  author: braun
)

BookCategory.create(
  book: book3,
  category: biography
)

BookCategory.create(
  book: book3,
  category: inspiration
)

BookCategory.create(
  book: book3,
  category: motivation
)

book4 = Book.create(
  title: "Becoming a Supple Leopard 2nd Edition: The Ultimate Guide to Resolving Pain, Preventing Injury, and Optimizing Athletic Performance",
  description: "Improve your athletic performance, extend your athletic career, treat stiffness and achy joints, and prevent and rehabilitate injuries—all without having to seek out a coach, doctor, chiropractor, physical therapist, or masseur. In Becoming a Supple Leopard, Dr. Kelly Starrett—founder of MobilityWOD.com—shares his revolutionary approach to mobility and maintenance of the human body and teaches you how to hack your own movement, allowing you to live a healthier, more fulfilling life. This new edition of the New York Times and Wall Street Journal bestseller has been thoroughly revised to make it even easier to put to use.",
  year_published: 2018,
  fiction: false,
)

BookAuthor.create(
  book: book4,
  author: starrett
)

BookAuthor.create(
  book: book4,
  author: cordoza
)

BookCategory.create(
  book: book4,
  category: strength
)

BookCategory.create(
  book: book4,
  category: flexibility
)

BookCategory.create(
  book: book4,
  category: mobility
)

puts "Success!"
