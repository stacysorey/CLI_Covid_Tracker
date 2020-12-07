class Stats
    
    attr_accessor :date, :state, :positive, :negative, :recovered, :death, :hospitalized, :total

    @@all = []

    def initialize(date, state, positive, negative, recovered, death, hospitalized, total)
        @date = date
        @state = state
        @positive = positive
        @negative = negative
        @recovered = recovered
        @death = death
        @hospitalized = hospitalized
        @total = total
        save
    end 

    def self.all
        @@all
    end
    
    def self.find_states
        @@all.select {|s| s.state != nil}
    end

    def self.find_national
        @@all.find {|s| s.state == nil}
    end

    def save
        @@all << self
    end

end