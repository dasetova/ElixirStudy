# Repositorio personal de estudio de Elixir
**Basado en libro Introducing Elixir - Simon St. Laurent & J. David Eisenberg**

## Capítulo 1 - Introduccion:
+ Lenguaje funcional basado en Erlang. Por lo anterior, la compilación de un archivo elixir produce un archivo .beam de Erlang
+ Es necesario tener instalado Erlang, que realiza la misma tarea de máquina virtual como la JVM o .NET Framework en otros lenguajes.

## Capítulo 2 - Módulos y funciones:
+ **Módulo:** Mismo concepto de clases en otros lenguajes como Java
+ **Función:** Mismo concepto de métodos en otros lenguajes como Java
+ **ex:**  Extension de un modulo en elixir
+ **c(module_file):** Comando de elixir para compilar
+ **exs:** Archivo que contiene varios comandos de elixir para ser ejecutados en una sola línea
+ **drop.ex:** Archivo que contienen un ejemplo basico de creacion de modulo con funciones públicas y privadas

## Capítulo 3 - Atoms, Tupples and Pattern Matching
+ **Atom:** Una especia de variable definida por los ":" con un nombre, el valor que guarda es el mismo nombre. Ver la implementación realizada sobre las funciones del módulo drop. Pueden contener en su nombre "_" o "@".
+ **Guards:** Añadir una condición para ejecutar una función, evitando errores. Esta validación se hace a través de la palabra when antes del do de la función.
+ **Argumentos ignorados:** Para ignorar un argumento en una función sin que el compilador genere un warning, se debe colocar un "_" en la posición del argumento que no se va a usar.
+ **Tuplas:** Estructura que puede contener cualquier cosa, generalmente se coloca un atom al principio que especifica su uso. Va en orden de 0 a n. 
+ **Funciones sobre las tuplas:** elem-> obtener un valor; put_elem -> ingresar un valor; tuple_size -> conocer el tamaño.

## Capítulo 4: Logic and Recursion
+ **case:** Validacion de tipo switch --> case, ver archivo drop. Se puede guardar el resultado en una variable. Cada posibilidad del case puede contener un guard (when).
+ **cond:** Realiza varias validaciones, se asemeja a un if...elseif.. anidado. También se puede guardar el resultado en una variable.
+ **IO.puts:** Imprime en consola una línea.
+ **Recursing:** Llamado de la "misma funcion" de esta misma. Es parcialmente cierto, dado que en elixir es preferible llevar el control del final de la recursividad mediante otra función igual con diferente guard. Podría hacerse en una misma función con un if pero es mejor visto o mejor práctica mantener todo separado mediante guards.

## Capítulo 5: Communicating with Humans
+ **Comilla, salto de linea y backslash en texto:** "Quote - \" in a string. \n Backslash, too: \\ . \n"
+ **Concantenación:** Se realiza mediante el "<>". "el" <> "ixir" retornaría "elixir"
+ **Interpolación:** Se hace mediante el {}. IO.puts("#{n} yields #{result}.") El interior es procesado para obtener un valor.
+ **Comparación de cadenas:** Se puede utilizar == (exacto) o === (estrictamente igual)
+ **Cadena multilínea:** Se inicia y finaliza con """ 
+ **Characters list:** Propio de erlang, el valor va en comilla simple 'valor' y se concatena con ++. 'el' ++ 'ixir' = 'elixir'. List.to_string y String.to_char_list se pueden usar para convertir entre cadenas y listas de caracteres.
+ **String Sigils:** Establece el tipo de caracteres que contendran una cadena. Inicia con ~ más el caracter:
    + *s:* Binary String
    + *c:* Lista de caracteres
    + *r:* Expresión regular
    + *w:* Lista dividida en palabras por espacios en blanco
+ **Solicitar información al usuario:** 
    + *IO.getn:* Permite obtener algunos caracteres, ver ejemplo en archivo ask.ex
    + *IO.gets:* Permite recibir una linea completa de texto, ver ejemplo en archivo ask.ex

## Capítulo 6: Lists
+ **List basics**
    + *Generalidades:* Ordenada y recorrida en orden generalmente (del primero al último)
    + *No tipadas:* Pueden contener cualquier tipo de dato, pero se recomienda trabajar con un único tipo
    + *Pattern:* [1,x,4,y] = [1,2,4,8] Se tiene que x=2; y=8
    + *Lista en otra:* insert = [2,4,8]; full = [1,insert,16,32] ocasiona full = [1,[2,4,8],16,32]. 
    + *List.flatten:* Para aplanar la lista anterior en una sóla lista con List.flatten(full); se obtiene full = [1,2,4,8,16,32]
    + *Lista de listas:* a = [1,2,4]; b = [8,16,32]; list_of_lists = [a,b]  (esto es [[1,2,4],[8,16,32]]).
    + *Enum.concat:* Combinar dos listas con Enum.concat(a,b) o con '++' => a ++ b
    + *Heads and Tails:* [head | tail] = [1,2,4] guarda la primera posición en la variable definida para el head y el resto en la variable definida para el tail.
    + *Enum.reverse:* Invierte la lista
    + *List.zip:* Une dos listas del mismo tamaño como una tupla
    + *List.unzip:* Separa una tupla en dos listas

## Capítulo 7: Name-Value Pairs
+ **Keyword lists:**
    + *Definicion:* Lista de pares Key-Value, donde el Key es un atom. La llave se puede repetir
    + *Ejemplo:* planemo_list = [{:earth, 9.8}, {:moon, 1.6}, {:mars, 3.71}]
    + *Keyword.get(list, :key):* Devuelve el primer valor con esa llave
    + *Keyword.get(list, :key, optional):* Si no encuentra la llave, devuelve el valor optional por defecto
    + *Keyword.fetch!(list, :key):* Devuelve un error si no encuentra la llave
    + *Keyword.get_values(list, :key):* Devuelve todos los valores con esa llave
    + *Keyword.has_key?(list, :key):* Devuelve true o false si existo o no la llave en la lista.
    + *Keyword.put_new(list, :key, value):* Agrega un nuevo campo. Si la llave ya existe no la modifica
    + *Keyword.put(list, :key, value):* Agrega un nuevo campo si no existe, si ya existe modifica todas las llaves por el valor nuevo (solo deja uno sin repetir).
+ **List of Tuples with Multiple Keys:**
    + *Definición:* Se puede tener una lista en la que se tengan varias llaves.
    + *Ejemplo:* atomic_info = [{:hydrogen, :H, 1008}, {:carbon, :C, 12.011}]
    + *List.keyfind(list, :key, key_position):* Se debe pasar la posición en la que se espera que este la llave. Si no está, devuelve nil
    + *List.keyfind(list, :key, key_position, default_value):* Igual que el anterior, pero devuelve el default_value si no se encuentra.
    + *List.keymember?(list, :key, key_position):* True o False si la llave se encuentra en esa posición
    + *List.keystore(list, :key, key_position, tuple):* Se inserta la tupla en la lista, siempre en una nueva lista apartir de la original.
    + *List.keyreplace(list, :key, key_position, tuple):* Reemplaza por la nueva tupla.
    + *List.keydelete(list, :key, key_position):* Elimina si la encuentra.
+ **Hash Dictionaries:**
    + *Definición:* Las llaves son únicas. Array asociativo.
    + *Creación:* planemo_hash = Enum.into([earth: 9.8, moon: 1.6, mars: 3.71],
HashDict.new())
    + *HashDict.function():* Usa las mismas funciones que el Keyword

+ **From lists to maps:**
    + *Creación:%{}* new_map = %{key=>value} Las llaves pueden ser atoms o cualquier cosa.
    + *Actualización:* altered_map = %{previous_map | key: value} o altered_map = %{previous_map | key => value, (key=>value...)}
    + *Leyendo:* %{earth: earth_gravity} = planemo_map. earth_gravity va a contener el valor de la llave earth.

+ **From maps to structs:**
    + *Definición:* Struct define una estructura para usar en la creación, se basa en maps.
    + *Protocols:* Similar a Interface en otros lenguajes, es implementado para las estructuras

## Capítulo 8 - High-Order Functions and List Comprehensions
+ Funciones que reciben otras funciones como parámetros
+ **Funciones de Alto orden con listas**
    + *Enum.each:* Recibe una lista y la función, lo que realiza es que ejecuta dicha función para cada elemento de la lista. Retorna el atom :ok al finalizar
    + *Enum.map:* Recibe una lista y la función, lo que realiza es que aplica la función para todos los elementos pero devuelve una nueva lista con los resultados.
    + *ForEach -> NewList:* Realizar la misma tarea del Enum.map con un foreach. for value <- list, do: value * value (For each value in list list , create an entry value * value in a new list) 
    + *Enum.filter:* Recibe la lista y la función. Devuelve los elementos de la lista para los que la función devuelve true.
+ **Testing lists**
    + *Enum.all?:* Recibe la lista y la función y valida si todos los elementos de la lista cumplen la función.
    + *Enum.any?:* Recibe la lista y la función y valida si al menos uno de los elementos de la lista cumple la función.
+ **Splitting lists**
    + *Enum.partition:* Realiza algo parecido a filter pero devuelve dos listas separadas con los que cumplen y no cumplen la función.
    + *Enum.take_while:* Devuelve la lista de los elementos que cumplen la condición hasta que encuentra uno que no cumple.
    + *Enum.drop_while:* Contrario a la anterior, devuelve la lista a partir del que no cumple.
+ **Folding**
    + Se define una función con un acumulador que irá cambiando a medida que se recorre la lista.
    + *list.foldl:* Recorre de head to tail.
    + *list.foldr:* Recorre de tail to head.

## Capítulo 9 - Playing with Processes
+ *send(pid, message):* Función que recibe el process_id y el mensaje a enviar.
+ *self():* Devuelve el proceso de la consola de elixir
+ *flush()*: "Lee" los mensajes pendientes del proceso de la shell.
+ *receive do:* Lee el mensaje pero permite hacer algo con el antes de descartarlo.
    receive do
        x -> x *2
    end
+ *spawn(module, :function, parameters[]):* Devuelve el pid de una función para enviarle un mensaje. Si se quiere seguir usando es necesario usar una llamada recursiva sobre la función que tiene el receive .. do (ver archivo bounce.ex)
+ **Registering a Process**
    + *Process.register(pid, :atom):* Permite registar un proceso para luego ser usado a través del atom.
        send(:atom, :message)
    + *Process.whereis(:atom):* Devuelve el pid del proceso registrado con ese atom. Si no existe ninguno devuelve nil.
    + *Process.unregister(:atom):* Devuelve true si existe, retira el registro creado para ese atom.
    + *Process.registered():* Devuelve todos los registrados.
## Capítulo 10 - Exceptions, errors and debugging
+ *try..rescue:* Bloque similar al try catch en otros lenguajes de progrmaación, también permite diferenciar la acción a realizar por tipos de excepción.
+ *Logging:* Usa diferentes niveles de log, :info, :debug, :warn, :error
+ *:dbg.tracer():* Función Erlang que activa el debug
+ *:dbg.p(pid, :m):* Establece que el debug para monitorear los mensajes (identificados por :m) de este proceso.
+ *ExUnit:* Modulo de testing de elixir.
    + *assert:* Evalúa que sea correcto
    + *refute:* Evalúa que la condición sea falsa
    + *assert_raise:* Evalúa que se genera una excepción

## Capítulo 11 - Storing Structured Data
+ **Records**
    + Propios de Erlang
    + *defrecord:* Define un record.
        Ej: defrecord Planemo, name: :nil, gravity: 0, diameter: 0, distance_from_sun: 0
    + *require:* Se debe usar antes de poder crear algún registro

+ **Erlang Term Storage**
    + Almacenamiento en memoria
    + Cada colección se comporta como una tabla de base de datos. Según el tratamiento que se tenga de la llave (similar a la pk de una tabla) se entienden como:
        + *Sets:* Sólo puede contener un único record con la llave. Default.
        + *Ordered sets:* Igual que sets pero en orden según la llave.
        + *Bags:* Puede tener varios registros con la misma llave, pero si varios registros son completamente iguales son unidos en uno sólo.
        + *Duplicate bags:* Igual que bags pero no une registros idénticos.
        + *ets.new:* Crea una nueva tabla.
            planemo_table = :ets.new(:planemos, [:named_table, {:keypos, Planemo.planemo(:name) + 1}])
        + *ets.insert:* Inserta un registro en la tabla. :ets.insert :table, record
            :ets.insert :planemos, Planemo.planemo(name: :mercury, gravity: 3.7, diameter: 4878, distance_from_sun: 57.9)
        + *ets.delete(:table):* Eliminar la tabla según el nombre
            :ets.delete(:planemos)
        + *ets.tab2list:* Lista el contenido de la tabla
            :ets.tab2list :planemos
        + *ets.lookup:* Reciibe la tabla y la llave para mostrar el registro
            :ets.lookup(:planemos, :eris)
        + *hd():* devuelve el primero de los registros de una tabla
            hd(:ets.lookup(:planemos, :eris))
        + *DETS:* ETS pero se guarda en el disco y no en memoria.
+ **Storing Records in Mnesia**
    +*Mnesia:* DBMS de Erlang.