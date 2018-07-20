defmodule Fact do
    
    def factorial(n) when n > 1 do
        IO.puts("Calling from #{n}.")
        result = n * factorial(n-1)
        IO.puts("#{n} yields #{result}.")
        result
    end

    def factorial(n) when n <= 1 do
        IO.puts("Calling from 1.")
        IO.puts("1 yields 1.")
        1
    end

    def factorial_count(n) do
        factorial_count(1,n,1)
    end

    defp factorial_count(current, n, result) when current<=n do
        new_result = result*current
        IO.puts("#{current} yields #{new_result}")
        factorial_count(current+1, n, new_result)
    end

    defp factorial_count(current, n, result) do
        IO.puts("Finished!")
        result
    end

end