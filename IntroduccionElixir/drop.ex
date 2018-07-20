defmodule Drop do

    require Planemo
    @moduledoc """
    Modulo de diferentes creaciones para fall_velocity
    El calculo de la velocidad de caída de un cuerpo en diferentes "planemos"
    """

    #Para importar un modulo de Erlang se debe usar :
    import :math, only: [sqrt: 1] #Only permite solo importar esa funcion
    #El import se puede hacer dentro del modulo o dentro de la funcion que lo va usar si solo una funcion requiere usar dicho modulo
    #import :math, except: [sin: 1, cos: 1] #Este import trae todas las funciones excepto las definidas


    @doc """
        Trasladando la validacion adentro de la funcion y no creando tres funciones
        También se puede hacer sin la variable gravity
    """
    def fall_velocity_case(planemo, distance) when distance >= 0 do
        gravity = case planemo do
            :earth -> 9.8
            :moon -> 1.6
            :mars -> 3.71
        end
        sqrt(2*gravity*distance)
    end

    def fall_velocity_case_when(planemo, distance) do
        gravity = case planemo do
            :earth when distance >= 0 -> 9.8
            :moon when distance >= 0 -> 1.6
            :mars when distance >= 0 -> 3.71
        end
        sqrt(2*gravity*distance)
    end

    def fall_velocity_case_cond(planemo, distance) when distance >= 0 do
        gravity = case planemo do
            :earth -> 9.8 
            :moon -> 1.6 
            :mars -> 3.71
        end
        
        velocity = sqrt(2 * gravity * distance)

        cond do
            velocity == 0 -> :stable
            velocity < 5 -> :slow
            velocity >= 5 and velocity < 10 -> :moving
            velocity >= 10 and velocity < 20 -> :fast
            velocity >= 20 -> :speedy
        end
    end
    
    def fall_velocity_if(planemo, distance) do
        velocity = 0
        try do
            gravity = case planemo do
                :earth -> 9.8
                :moon -> 1.6
                :mars -> 3.71
            end
        #Cambio de guard a try..rescue
        
            velocity = sqrt(2 * gravity * distance)
        rescue
            ArithmeticError -> {:error, "Distance must be non-negative"} #Como un catch
            CaseClauseError -> {:error, "Unknown planemo #{planemo}"}  #Plus.. Otro catch
        end
        

        if velocity > 20 do
            IO.puts("Look out below!")
        else
            IO.puts("Reasonable...")
        end

        velocity
    end
    
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


    def drop do
        setup
        handle_drops
    end

    
    def handle_drops do
        receive do
            {from, planemo, distance} ->
             send(from, {planemo, distance, fall_velocity(planemo, distance)})
            handle_drops()
        end
        
    end

    def fall_velocity(planemo, distance) when distance >= 0 do
        p = hd(:ets.lookup(:planemos, planemo))
        :math.sqrt(2 * Planemo.planemo(p, :gravity) * distance)
    end

    def setup do
        :ets.new(:planemos, [:named_table,
            {:keypos, Planemo.__record__(:index, :name) + 1}])
        info = [
            {:mercury, 3.7, 4878, 57.9},
            {:venus, 8.9, 12104, 108.2},
            {:earth, 9.8, 12756, 149.6},
            {:moon, 1.6, 3475, 149.6},
            {:mars, 3.7, 6787, 227.9},
            {:ceres, 0.27, 950, 413.7},
            {:jupiter, 23.1, 142796, 778.3},
            {:saturn, 9.0, 120660, 1427.0},
            {:uranus, 8.7, 51118, 2871.0},
            {:neptune, 11.0, 30200, 4497.1},
            {:pluto, 0.6, 2300, 5913.0},
            {:haumea, 0.44, 1150, 6484.0},
            {:makemake, 0.5, 1500, 6850.0},
            {:eris, 0.8, 2400, 10210.0}]
        insert_into_table(info)
    end

    def insert_into_table([]) do
        :undefined
    end

    def insert_into_table([{name, gravity, diameter, distance} | tail]) do
        :ets.insert(:planemos, Planemo.new(name: name, gravity: gravity, diameter: diameter, distance_from_sun: distance))
        insert_into_table(tail)
    end

end