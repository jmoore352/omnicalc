class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================



    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.length

    @occurrences = @text.downcase.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    total_payments = @years * 12
    eff_int = @apr / 100 / 12
    @monthly_payment = @principal *(eff_int / (1 - (1 + eff_int)**-total_payments))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 1.minute
    @hours = @seconds / 1.hour
    @days = @seconds / 1.day
    @weeks = @seconds / 1.week
    @years = @seconds / 1.year

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    def sum list_of_numbers
        running_total = 0
        list_of_numbers.each do |number|
        running_total = running_total + number
    end
    return running_total
    end

    def mean list_of_numbers
        mean = @sum / @count
    return mean
    end

    def count list_of_numbers
        count = @numbers.count
    return count
    end

    min = @numbers.min
    max = @numbers.max
    range = max - min


    def range list_of_numbers

    end


    def variance list_of_numbers
        variance = 0
        list_of_numbers.each do |number|
        variance = variance + (number - (mean list_of_numbers))**2
    end
    variance = variance / list_of_numbers.count
    return variance
    end

    def std_dev list_of_numbers
        std_dev = (variance list_of_numbers) ** (0.5)
        return std_dev
    end

    def median list_of_numbers
    if (count list_of_numbers).odd? == true
        median = @numbers.sort[((count list_of_numbers)) / 2]
    else
        median = (@numbers.sort[(count list_of_numbers) / 2 -1] +
                @numbers.sort[((count list_of_numbers)  / 2 -1) + 1]) / 2
    end
    return median
    end

    def mode list_of_numbers
        count_list = {}
        list_of_numbers.each do |number|
        number_tracker = number
        modecount = list_of_numbers.count(number)
        count_list[number_tracker] =  modecount
    end
    return count_list.max_by{|k,v| v}
    end

    @sorted_numbers = @numbers.sort

    @count = count @numbers

    @minimum = min

    @maximum = max

    @range = range

    @median = median @numbers

    @sum = sum @numbers

    @mean = mean @numbers

    @variance = variance @numbers

    @standard_deviation = std_dev @numbers

    @mode = mode @numbers

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
