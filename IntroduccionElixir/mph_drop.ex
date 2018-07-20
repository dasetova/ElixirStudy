defmodule MphDrop do
    def mph_drop do
        Process.flag(:trap_exit, true)
        drop_pid = spawn_link(Drop, :drop, [])#Esto permite que falle el otro proceso
        #Este tambien sea finalizado
        #spawn(Drop, :drop, [])
        convert(drop_pid)
    end

    def convert(drop_pid) do
        receive do
            {planemo, distance} -> #Este realiza el envio del mensaje
            send(drop_pid, {self(), planemo, distance})
            convert(drop_pid)
            {:EXIT, pid, reason} ->
            IO.puts("Failure: #{inspect(pid)} #{inspect(reason)}")
            new_drop_id = spawn_link(Drop, :drop, [])#Como fallo, se realiza de nuevo
            convert(new_drop_id)
            {planemo, distance, velocity} ->#Este recibe la respuesta
            mph_velocity = 2.23693629 * velocity
            IO.write("On #{planemo}, a fall of #{distance} meters ")
            IO.puts("yields a velocity of #{mph_velocity} mph.")
            convert(drop_pid)
        end
        
    end
end