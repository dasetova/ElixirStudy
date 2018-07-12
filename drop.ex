defmodule Drop do
    #Para importar un modulo de Erlang se debe usar :
    import :math, only: [sqrt: 1] #Only permite solo importar esa funcion
    #El import se puede hacer dentro del modulo o dentro de la funcion que lo va usar si solo una funcion requiere usar dicho modulo
    #import :math, except: [sin: 1, cos: 1] #Este import trae todas las funciones excepto las definidas


    @doc """
        Método para calcular la velocidad de caída, el parámetro gravedad es opcional
    """
    #def fall_velocity(distance, gravity \\ 9.8) do
    #    sqrt(2*9.8*distance)
    #end

    def fall_velocity(:earth, distance) when distance >= 0 do
        sqrt(2*9.8*distance)
    end

    def fall_velocity(:moon, distance) when distance >= 0 do
        sqrt(2*1.6*distance)
    end

    def fall_velocity(:mars, distance) when distance >= 0 do
        sqrt(2*3.71*distance)
    end

    #defp la declare como privada
    defp another() do
        0
    end
end