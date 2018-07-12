defmodule Drop do
    #def declara la funcion como publica
    def fall_velocity(distance) do
        :math.sqrt(2*9.8*distance)
    end

    def mps_to_mph(mps) do
        2.23693629 * mps
    end

    def mps_to_kph(mps) do
        3.6 * mps
    end

    #defp la declare como privada
    defp another() do
        0
    end
end