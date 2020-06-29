def input_students
  students = []
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  
  while !name.empty? do
    puts "Please enter the cohort"
    cohort = gets.chomp
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  students.each.with_index(1) do |student, number|
    puts "#{number}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def interactive_menu
  students = []
  loop do 
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection 
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit
      else 
        puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
