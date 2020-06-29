@students = []
@possible_cohorts = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  
  while !name.empty? do
    puts "Please enter the cohort"
    cohort = gets.chomp.downcase.capitalize
    while !@possible_cohorts.include? cohort
      puts "That is not a recognized cohort, please try again"
      cohort = gets.chomp
    end
    @students << {name: name, cohort: cohort}
    puts "Now we have #{@students.count} students"
    name = gets.chomp
  end
  @students
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

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end 

def process(selection)
  case selection 
      when "1"
        @students = input_students
      when "2"
        show_students
      when "9"
        exit
      else 
        puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do 
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
