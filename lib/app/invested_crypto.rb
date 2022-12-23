require_relative './player.rb'
require_relative './crypto_list.rb'

class InvestedCrypto 

    attr_accessor :name, :entry_rate, :exit_rate, :amount_invested, :number_owned, :total_amount
    @@all = []
    @@pastel = Pastel.new
    @@prompt = TTY::Prompt.new

    def initialize name="", entry_rate=0, exit_rate=0, amount_invested=0, number_owned=0, total_amount=0
        @name = name 
        @entry_rate = entry_rate
        @exit_rate = exit_rate
        @amount_invested = amount_invested
        @number_owned = number_owned
        @total_amount = total_amount
        @@all << self
    end

    def self.all 
        @@all
    end

    def self.clear 
        @@all.clear
    end

    def self.add_to_player
        Player.all[0].crypto_invested = @@all
    end

    def self.ask_for_number 
        @@prompt.ask("Please select the number for coin 
            you want to invest:") do |q|
            q.validate(/^([1-9]|1[012345])$/, "Invalid Input")
        end
    end

    def self.ask_for_amount 
        @@prompt.ask("
            Please type the amount you want to invest:")
    end

    def self.set_invested_crypto_details(invested_crypto, name, rate, amount)
        invested_crypto.name = name
        invested_crypto.entry_rate = rate
        invested_crypto.amount_invested = amount.to_i
        invested_crypto.number_owned = (amount.to_i / rate).to_f.round(3)
    end
    

    def self.select_crypto_to_invest
        player_new = Player.all[0]
        until  player_new.balance <= 0 do 

            invested_crypto = InvestedCrypto.new

            selection = ask_for_number
            amount_invested = ask_for_amount
            
            selection_name = player_new.past_crypto_list.each_with_index.select{|crypto, index| selection.to_i == (index+1)}
            player_new.balance = player_new.balance - amount_invested.to_i

            puts @@pastel.cyan.bold("
                You have invested #{amount_invested} AUD
                in #{selection_name[0][0][0].upcase}.
                
                You have #{player_new.balance} AUD left
                
                ")
            
            set_invested_crypto_details(invested_crypto, selection_name[0][0][0], selection_name[0][0][2], amount_invested )
            if_balance_negative?
        end    
    end

    def self.if_balance_negative? 
        if Player.all[0].balance.negative?
            @@all.last.amount_invested -= Player.all[0].balance.abs
            sleep(2)
            puts @@pastel.cyan.bold("
                Due to insufficient balance, you have only
                invested #{@@all.last.amount_invested} in 
                #{@@all.last.name.upcase}")
            Player.all[0].balance = 0
        end
    end

    def self.show_investments 
        puts @@pastel.cyan.bold("

                Below is your INVESTMENTS......


                Coin-Name             Owned            Invested(AUD)
              --------------       -----------       -----------------  
           ")
        @@all.each do |i|

            puts @@pastel.green.bold("
                #{i.name.upcase}             #{i.number_owned}              #{i.amount_invested}
            
                ")
        end
    end

    def self.set_exit_rate 
        Player.all[0].exited_crypto_data.each do |exited_data|
            @@all.each do |investment|
                if exited_data[0] == investment.name
                    investment.exit_rate = exited_data[2]
                end
            end
        end
    end

    def self.set_and_show_total_amount
        puts @@pastel.cyan.bold("

                Below is your investments' CALCULATIONS......


                Coin-Name             Owned            Invested(AUD)             TotalAmount(AUD)
              --------------       -----------       -----------------          -----------------
           ")
        @@all.each do |i|
            i.total_amount = (i.number_owned * i.exit_rate).to_f.round(3)
            puts @@pastel.green.bold("
                #{i.name.upcase}              #{i.number_owned}               #{i.amount_invested}                   #{i.total_amount}
            
                ")
        end
        total
    end

    def self.total
        total_of_totals = 0
        @@all.each do |i|
            total_of_totals += i.total_amount
        end
        Player.all[0].total_balance = total_of_totals.to_f.round(3)
    end
end