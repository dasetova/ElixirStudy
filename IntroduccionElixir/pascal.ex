defmodule Pascal do
    @moduledoc """
    Modulo que implementa una lista de listas para el calculo del triangulo de Pascal
    """

    def triangle(rows) do
        triangle([[0,1,0]], 1, rows)
    end

    def triangle(list, count, rows) when count >= rows do
        Enum.reverse(list)
    end

    def triangle(list, count, rows) do
        [previous | _] = list
        triangle([add_row(previous) | list], count + 1, rows)
    end

    @doc """
    
    """
    def add_row(initial) do
        add_row(initial, 0, [])
    end

    @doc """
    
    """
    def add_row([], 0, final) do
        [0 | final]
    end

    @doc """
    
    """
    def add_row([h | t], last, new) do
        add_row(t,h, [last + h | new])
    end
end