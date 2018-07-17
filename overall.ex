defmodule Overall do
    @moduledoc """
    Este modulo es creado para el entendimiento del manejo de head y tails
    Este módulo es realizado para segun una lista recibida se devuelva el valor
    de la multiplicación de todos los elementos que la componen
    """

    @doc """
    Esta función devolverá 0 cuando se reciba una lista vacía
    """
    def product([]) do
        0
    end

    @doc """
    Esta función será la que reciba la lista ingresada y llamará la función que
    se encarga realmente de separar el head en cada iteración y multiplicar con
    lo acumulado
    """
    def product(list) do
        product(list,1)
    end

    @doc """
    Esta función solamente devolverá el valor acumulado cuando la lista ya se
    encuentre vacía
    """
    def product([], accumulated_product) do
        accumulated_product
    end

    @doc """
    Esta función es la que realiza el mayor trabajo, separar el head y multiplicarlo
    por lo acumulado hasta el momento y enviar el tail para seguir procesando
    """
    def product([head | tail], accumulated_product) do
        product(tail, head * accumulated_product)
    end
end