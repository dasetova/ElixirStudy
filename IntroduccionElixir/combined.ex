defmodule Combined do
    @moduledoc """
    Permite documentar un modulo.
    Este modulo es para probar el uso de modulos desde un tercero
    """
    import Convert

    @doc """
    Comentario para una funcion. Este metodo permite convertir de altura a velocidad de caida
    """
    def height_to_mph(meters) do
        #Convert.mps_to_mph(Drop.fall_velocity(meters))
        #Usa el resultado de Drop.fall_velocity y lo envia como parametros de Convert.mps_to_mph
        #Drop.fall_velocity(meters) |> Convert.mps_to_mph
        #Con el import
        mps_to_mph(Drop.fall_velocity(meters))
    end
end