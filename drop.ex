defmodule Drop do
    #def declara la funcion como publica
    def fall_velocity(distance) do
        :math.sqrt(2*9.8*distance)
    end

    #defp la declare como privada
    defp another() do
        0
    end
end