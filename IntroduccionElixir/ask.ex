defmodule Ask do
    
    def chars() do
        IO.puts(
            """
                Which planemo are you on?
                1. Earth
                2. Moon
                3. Mars
            """
        )
        IO.getn("Which? > ")
    end

    def line() do
        planemo = get_planemo()
        distance = get_distance()
        Drop.fall_velocity({planemo,distance})
    end

    defp get_planemo() do
        IO.puts(
            """
                Which planemo are you on?
                1. Earth
                2. Moon
                3. Mars
            """
        )
        answer = IO.gets("Which? > ") #Obtiene una cadena
        value = String.first(answer) #extrae el primero
        char_to_planemo(value) #convierte a planemo y retorna
    end

    defp get_distance() do
        input = IO.gets("How far? (meters) > ")#Recibe cadena
        value = String.trim(input)#elimina espacios en blanco
        String.to_integer(value)#convierte a int
    end

    defp char_to_planemo(char) do
        case char do
            "1" -> :earth
            "2" -> :moon
            "3" -> :mars
        end
    end

end