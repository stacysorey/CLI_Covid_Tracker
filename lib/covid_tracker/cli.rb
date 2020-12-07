class CLI

    def call
        puts ""
        puts "------Welcome to your COVID-19 report.------"
        puts ""
        puts "-------Information is updated daily.--------"
        puts ""
        start
    end

    def start
        
        puts ""
        puts "Enter (N) for national data OR enter (S) for state data"
        puts ""

        input = gets.strip.downcase
        if input == "s"
        API.state_data
        pick_state
        elsif input == "n"
            API.national_data
            list_national_data
        else
            puts "Incorrect input"
            start
        end

        puts ""
        puts "Would you like to see another report? Enter (Y) or (N)"
        puts ""

        input = gets.strip.downcase
        if input == "y"
            start
        elsif input == "n"
            puts ""
            puts ""
            puts "Be safe and wear a mask!"
            puts ""
            exit
        else
            puts ""
            puts "Incorrect input."
            start
        end
    end

   def pick_state
    states = Stats.find_states
    states.each.with_index(1) do |state, index|
        puts "#{index}. #{state.state}"
    #input = gets.strip.to_i
    
    end
    puts "Pick a number of a state you want a report for"
    input = gets.strip.to_i
    list_state_data(input)
    #make sure it doesn't go over 56
   end

   def list_state_data(input)
    index = input - 1
    state = Stats.find_states[index]
    puts ""
    puts "Report for #{state.state} on #{state.date}:"
    list_stats(state)
    puts "Total Tested Cases:   #{state.total}"
    puts ""
    puts ""
   end
   #if called multiple times, lists states multiple times (up to 160s)
   #put a note about territories

   def list_national_data
    nat = Stats.find_national
    puts ""
    puts "National Report for #{nat.date}:"
    list_stats(nat)
    
   end

   def list_stats(stat)
    puts ""
    puts ""                 
    puts "Total Positive Cases: #{stat.positive}"
    puts "Total Negative Cases: #{stat.negative}"
    puts "Total Recovered:      #{stat.recovered}"
    puts "Total Deaths:         #{stat.death}"
    puts "Total Hospitalized:   #{stat.hospitalized}"
   end

end