defmodule StructDrop do
    import :math, only: [sqrt: 1]

    #def fall_velocity(t) do
    #def fall_velocity(%Tower{planemo: planemo, height: distance}) do
    #    fall_velocity(t.planemo, t.height)
    def fall_velocity(t = %Tower{planemo: planemo, height: distance}) do
        IO.puts("From #{t.name}'s elevation of #{distance} meters on #{planemo},")
        IO.puts("the object will reach #{fall_velocity(planemo, distance)} m/s")
        IO.puts("before crashing in #{t.location}")
    end

    def fall_velocity(:earth, distance) when distance >=0 do
        sqrt(2 * 9.8 * distance)    
    end

    def fall_velocity(:moon, distance) when distance >= 0 do
        sqrt(2 * 1.6 * distance)
    end

    def fall_velocity(:mars, distance) when distance >= 0 do
        sqrt(2 * 3.71 * distance)
    end
end