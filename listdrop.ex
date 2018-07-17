defmodule ListDrop do
    def falls(list) do
        falls(list,[])
    end

    def falls([],results) do
        Enum.reverse(results) #Corrección realizada para que el resultado salga en el mismo
        #orden que lo ingresado
    end

    @doc """
    Desencola la head de la lista original y va creando una nueva lista con el 
    resultado de fall_velocity según el planemo y la distancia enviada
    Ej: ListDrop.falls([{:earth, 20},{:moon, 20},{:mars, 20}])
    """
    def falls([head | tail], results) do
        falls(tail, [Drop.fall_velocity(head) | results])
    end
end