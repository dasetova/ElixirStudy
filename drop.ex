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

    @doc """
    Usando una tupla para definir cual implementación privada se invoca
    """
    def fall_velocity({planemo, distance}) do
        fall_velocity(planemo,distance)
    end

    #Otras implementacion con tuplas
    #def fall_velocity(where) do
     #   fall_velocity(elem(where,0), elem(where,1)) #Hace uso de la funcion elem que recibe la tupla y la posicion
    #end

    #def fall_velocity(where) do
     #   {planemo, distance} = where #Establece los nombres de las posiciones
     #  fall_velocity(planemo, distance)
    #end

    #defp la declare como privada

    defp fall_velocity(:earth, distance) when distance >= 0 do
        sqrt(2*9.8*distance)
    end

    defp fall_velocity(:moon, distance) when distance >= 0 do
        sqrt(2*1.6*distance)
    end

    defp fall_velocity(:mars, distance) when distance >= 0 do
        sqrt(2*3.71*distance)
    end
end