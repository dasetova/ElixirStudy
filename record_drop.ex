defmodule RecordDrop do
    #Es necesario usar require antes de usar un record
    require Planemo
    require Tower
    import Tower
    @doc """
    Se recibe un record de tipo tower dentro de la variable t
    """
    def fall_velocity(t = tower()) do
        #Se extraen los campos planemo y height para el calculo
        fall_velocity(tower(t, :planemo), tower(t, :height))
    end

    @doc """
    Otra opcion es recibir directamente los campos separados en dos variables
    """
    def fall_velocity_separate(tower(planemo: planemo, height: height)) do
        #Se extraen los campos planemo y height para el calculo
        fall_velocity(planemo, height)
    end

    def fall_velocity_message(t = tower(planemo: planemo, height: distance)) do
        IO.puts("From #{tower(t, :name)}'s elevation of #{distance} meters on #{planemo},")
        IO.puts("the object will reach #{fall_velocity(planemo,distance)} m/s")
        IO.puts("before crashing in #{tower(t, :location)}")
    end

    def fall_velocity(:earth, distance) when distance >= 0 do
        :math.sqrt(2 * 9.8 * distance)
    end
    def fall_velocity(:moon, distance) when distance >= 0 do
        :math.sqrt(2 * 1.6 * distance)
    end
    def fall_velocity(:mars, distance) when distance >= 0 do
        :math.sqrt(2 * 3.71 * distance)
    end
end