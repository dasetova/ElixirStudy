defmodule Count do
    
    def countdown(from) when from > 0 do
        IO.inspect(from)
        countdown(from-1)
    end

    def countdown(from) do
        IO.puts("blastoff!")
    end

    def countup(limit) do
        countup(1, limit)
    end

    defp countup(count, limit) when count <= limit do
        IO.inspect(count)
        countup(count+1, limit)
    end

    defp countup(count, limit) do
        IO.puts("finished!")
    end


end