class API

    @@stateurl = "https://api.covidtracking.com/v1/states/current.json"
    @@nationalurl = "https://api.covidtracking.com/v1/us/current.json"

    def self.get_data(url)
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        response.body       
    end

    def self.state_data
        states = JSON.parse(self.get_data(@@stateurl))
        states.each do |state|
            date = get_date(state["date"])
            st = state["state"]
            pos = state["positive"]
            positive = self.format_number(pos)
            neg = state["negative"]
            negative = self.format_number(neg)
            rec = state["recovered"]
            recovered = self.format_number(rec)
            dth = state["death"]
            death = self.format_number(dth)
            hos = state["hospitalized"]
            hospitalized = self.format_number(hos)
            tot = state["total"]
            total = self.format_number(tot)
            Stats.new(date, st, positive, negative, recovered, death, hospitalized, total)
        end
      end
      
    def self.national_data
        national = JSON.parse(self.get_data(@@nationalurl))
        date = get_date(national[0]["date"])
        state = national[0]["state"] #will be nil
        pos = national[0]["positive"]
        positive = self.format_number(pos)
        neg = national[0]["negative"]
        negative = self.format_number(neg)
        rec = national[0]["recovered"]
        recovered = self.format_number(rec)
        dth = national[0]["death"]
        death = self.format_number(dth)
        hos = national[0]["hospitalized"]
        hospitalized = self.format_number(hos)
        total = national[0]["total"] #will be 0
        Stats.new(date, state, positive, negative, recovered, death, hospitalized, total)
    end

    def self.format_number(number)
        number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end

    def self.get_date(date)
        date =  date.to_s
        # turns the date into a 2020-12-06
        date = Date.parse(date).to_s
        date_string = date.split("-")
        new_date =  Date.new(date_string[0].to_i, date_string[1].to_i, date_string[2].to_i)
        new_date.strftime("%B, %d %Y")
    end 
     
end