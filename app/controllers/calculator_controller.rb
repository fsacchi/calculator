include ActionView::Helpers::NumberHelper

class CalculatorController < ApplicationController
    before_action :initialize_display_number

    def index
        reset_text
    end

    def concat_text
        # Recebe o texto como parâmetro
        text = params[:text]
    
        # Concatena o texto com a variável
        @displayNumber ||= ''
        @displayNumber += text
        session[:displayNumber] = @displayNumber  # Armazena em sessão

        render :index
    end

    def operation
        # Recebe o texto como parâmetro
        operation = params[:operation]

        if !@displayNumber.nil? && !@displayNumber.empty?
            @numberOperation = @displayNumber.empty? ? 0.0 : @displayNumber.to_f

            if @last_operation.nil? || @last_operation.empty?
                if (@result == 0.0)
                    @result = @numberOperation
                end
                refreshScreen()
            else     
                calculate()
            end
        end        

        @last_operation = operation
        session[:last_operation] = @last_operation     


        render :index
    end

    def equals
        @numberOperation = @displayNumber.empty? ? 0.0 : @displayNumber.to_f
        calculate()
        @last_operation = ''
        session[:last_operation] = ''
        render :index
    end    

    def calculate

        case @last_operation
        when "+"
          @result = @result + @numberOperation
        when "-"
            @result = @result - @numberOperation
        when "*"
            @result = @result * @numberOperation
        when "/"
            if (@numberOperation > 0)
                @result = @result / @numberOperation
            end                
        end

        refreshScreen()
    end    

    def refreshScreen
        session[:result] = @result

        @displayNumber = ''
        session[:displayNumber] = ''

        @formatted_result = number_with_precision(@result, precision: 2, separator: ',', delimiter: '.')
        session[:formatted_result] = @formatted_result
    end    
   
    def reset_text
        @displayNumber = ''
        session[:displayNumber] = ''
        @result = 0.0
        session[:result] = 0.0 
        @formatted_result = ''
        session[:formatted_result] = ''
        @last_operation = ''
        session[:last_operation] = ''
        render :index
    end 

    def initialize_display_number
        @displayNumber = session[:displayNumber] || ''
        @result = session[:result] || 0.0
        @formatted_result = session[:formatted_result] || ''
        @last_operation = session[:last_operation] || ''
    end  

end
