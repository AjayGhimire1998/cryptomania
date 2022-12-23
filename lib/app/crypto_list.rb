require_relative '../../utility/Crypto_Calculator.rb'
require_relative './player.rb'
require_relative "../../utility/FancyText.rb"
require 'pastel'

class CryptoList 

    include CryptoCalculator::InstanceMethods
    include FancyText::InstanceMethods

    attr_accessor :crypto_list, :future_crypto_list


    def initialize crypto_list=nil, future_crypto_list=nil
        @crypto_list = CRYPTO_LIST
        @future_crypto_list = CRYPTO_LIST
    end

    def set_player_crypto_list_on_past
        Player.all[0].past_crypto_list = @crypto_list
    end

    def set_player_crypto_list_on_future
        Player.all[0].exited_crypto_data = @future_crypto_list
    end

    def show_list_iterator(list_crypto)
        pastel = Pastel.new 
        list_crypto.each.with_index(1) do |crypto, index|
            puts pastel.green.bold("
            #{index}. #{crypto[0].upcase}  -  #{crypto[1]}  -  #{crypto[2]} AUD
            ")     
        end
    end

    def list_past_data
        get_rate(@crypto_list, Player.all[0].entry_date)
        set_player_crypto_list_on_past
        progressbar(
            "Fetching currencies and their rates [:bar]",
            "
            Successfully Fetched!!
            
            " 
        )
        show_list_iterator(@crypto_list)
    end


    def list_future_data
        get_rate(@future_crypto_list, Player.all[0].exit_date)
        set_player_crypto_list_on_future

        show_list_iterator(@future_crypto_list)
    end

end


