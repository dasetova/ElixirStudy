# Programming Phoenix
Estudio del framework Phoenix basado en el libro "Programming Phoenix" de ...

## Chapter 2 - The Lay of the Land
* Conocimiento basico de elixir, dos funciones básicas:
    def inc(x), do: x + 1
    def dec(x), do: x - 1
* Consumo de estas funciones usando el operador | (pipe), el cuál significa que el valor del lado izquierdo es recibido como primer parámetro en la función del lado derecho:
    2 |> inc |> inc |> dec
    Esto es considero un pipeline
* Connection: En Phoenix contiene todo lo que se debe conocer de un request de un usuario. Cada capa de Phoenix la reciba y devuelve una versión modificada para, al final, contener también el response.
* Ejemplo básico de un pipeline real: La preparación de una torta: Los ingredientes son la base, lo cuál es mezclado (función mix) y el resultado de esta mezcla luego es horneado (función bake).
    ingredients
    |> mix
    |> bake
### The Layers of Phoenix
Las principales capas para comenzar a estudiar phoenix son las siguientes (ilustradas en modelo de pipeline):
    connection
    |> endpoint
    |> router
    |> pipelines
    |> controller
Cada conexión es recibida a través de un *endpoint*, el cuál cuenta con un *router* el cuál es el encargado de dirigir cada request a la función específica que la resolverá. Dentro del *router* existen diferentes *pipelines* que pueden resolver request recibidos de formulario de navegador o como un JSON. Cada request es enviado finalmente a un *controller* que contiene una acción especifica que resolvera este y devolverá la respuesta que atravesará lo anterior en sentido inverso.

### Installing Your Development Environment
* Erlang
* Elixir
* PostgreSQL: Normalmente es el utilizado con Ecto (capa de persistencia de Phoenix)
* Node.js
* inotify: Permite el *live reloading*

### Creating a Throwaway Project (Hello, World!)
Para crear un nuevo projecto de Phoenix se utiliza:
    mix phoenix.new project_name
*Mix es utilizado en elixir para simplificar las tareas repetitivas, como la creación de la estructura de un nuevo proyecto*
Tareas a realizar después de crear el proyecto:
* cd project_name: Cambia hacia la carpeta creada por el comando anterior.
* mix ecto.create: Crea la base de datos, es necesario verificar el archivo dentro de config/dev.exs para configurar correctamente las credenciales de postgesql.
* mix phoenix.server: Inicia la aplicación. También puede ser iniciada en iex con iex -S mix phoenix.server. *Actualizacion: mix phx.server*

### Building a feature
Para agregar funcionalidad a la aplicación recien creada, es necesario realizar:
* Creación de una ruta en el archivo /web/router.ex 
* Adicionar un controller (o una acción en uno ya existente).
* Una vista en web/views
* Una plantilla en web/templates: Código HTML embebido en un archivo exs
