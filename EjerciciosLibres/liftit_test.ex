defmodule LiftitTest do
    def convertListToMap(list) do
        list
            |> Enum.map(
                fn [date, meridian, id, value] -> 
                {date, {meridian, value}} 
                end
            )
            |> Map.new
    end

    

end