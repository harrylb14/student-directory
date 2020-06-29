require 'csv'
@students = []
@possible_cohorts = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

def interactive_menu
  loop do 
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection 
      when "1"
        @students = input_students
      when "2"
        show_students
      when "3"
        save_students
      when "4"
        load_students
      when "9"
        exit
      else 
        puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  
  while !name.empty? do
    puts "Please enter the cohort"
    cohort = STDIN.gets.chomp.downcase.capitalize
    while !@possible_cohorts.include? cohort
      puts "That is not a recognized cohort, please try again"
      cohort = STDIN.gets.chomp.downcase.capitalize
    end
    update_students(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  @students
end

def update_students(name, cohort)
  if !cohort.is_a? Symbol
    cohort = cohort.to_sym
  end
  @students << {name: name, cohort: cohort}
end

def show_students
  print_header
  print_student_list
  print_footer
end 

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each.with_index(1) do |student, number|
    puts "#{number}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  CSV.open("students.csv", "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename, "r") do |line|
      name, cohort = line[0], line[1]
      update_students(name, cohort)
  end
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu
