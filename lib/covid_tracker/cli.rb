class CLI
    @@cyn="\e[1;36m"
    @@blu="\e[1;34m"
    @@grn="\e[1;32m"
    @@red="\e[1;31m"
    @@underline="\e[1;4;31m"
    @@rem_line="\e[1;0m"
    @@white="\e[0m"

    def call
        puts ""
        puts "#{@@underline}------Welcome to Your COVID-19 Report------"
        puts ""
        puts "-------Information is Updated Daily--------#{@@rem_line}"
        puts ""
        start
    end

    def start
        
        puts ""
        puts "#{@@blu}Enter #{@@grn}(N) #{@@blu}for national data OR enter #{@@grn}(S) #{@@blu}for state data"
        puts "Enter #{@@grn}(E) #{@@blu}to exit"
        puts ""

        input = gets.strip.downcase
        if input == "s"
        API.state_data
        pick_state
        elsif input == "n"
            API.national_data
            list_national_data
        elsif input == "e"
            goodbye
        else
            puts "#{@@red}***Invalid Input***"
            start
        end
        

        puts ""
        puts "#{@@blu}Would you like to see another report? Enter #{@@grn}(Y) #{@@blu}or #{@@grn}(N)"
        puts ""

        input = gets.strip.downcase
        if input == "y"
            Stats.clear
            start
        elsif input == "n"
           goodbye
        else
            puts ""
            puts "#{@@red}***Invalid Input***"
            start
        end
    end

    def goodbye
        puts ""
        puts ""
        puts "#{@@cyn}Be safe and wear a mask!"
        puts ""
        exit
    end

    def pick_state
    puts ""
    puts "#{@@underline}----Input number for desired state or territory----#{@@rem_line}"
    puts ""
    puts "#{@@red} FOR YOUR REFERENCE:"
    puts ""
    puts "4.  #{@@white}AS = American Samoa    #{@@red}9. #{@@white}DC = District of Columbia"
    puts "#{@@red}13. #{@@white}GU = Guam             #{@@red}28. #{@@white}MP = Northern Marianas"
    puts "#{@@red}43. #{@@white}PR = Puerto Rico      #{@@red}51. #{@@white}VI = Virgin Islands"
    puts ""
    puts ""
    states = Stats.find_states
    states.each.with_index(1) do |state, index|
        puts "#{@@red}#{index}. #{@@white}#{state.state}#{@@red}"
    end
    
    input = gets.strip.to_i
    if input.between?(1, 56)  
        list_state_data(input)
    else
        puts ""
        puts "***Invalid Input***"
        puts ""
        puts "#{@@blu}Would you like to select again? #{@@grn}(Y) #{@@blu}or #{@@grn}(N)"
        puts ""
        pick = gets.strip.downcase
        if pick == "y"
            pick_state
        elsif pick == "n"
            goodbye
        else
            puts ""
            puts "#{@@red}***Invalid Input***"
            pick
        end
    end
    end

   def list_state_data(input)
    index = input - 1
    state = Stats.find_states[index]
    puts ""
    puts "#{@@underline}Report for #{state.state} on #{state.date}:#{@@rem_line}#{@@red}"
    list_stats(state)
    puts "Total Tested Cases:   #{@@white}#{state.total}"
    puts ""
    puts ""
   end
 
   def list_national_data
    nat = Stats.find_national
    puts ""
    puts "#{@@underline}National Report for #{nat.date}#{@@rem_line}#{@@red}:"
    list_stats(nat)
   end

   def list_stats(stat)
    puts ""
    puts ""                 
    puts "Total Positive Cases: #{@@white}#{stat.positive}#{@@red}"
    puts "Total Negative Cases: #{@@white}#{stat.negative}#{@@red}"
    puts "Total Recovered:      #{@@white}#{stat.recovered}#{@@red}"
    puts "Total Deaths:         #{@@white}#{stat.death}#{@@red}"
    puts "Total Hospitalized:   #{@@white}#{stat.hospitalized}#{@@red}"
   end

end