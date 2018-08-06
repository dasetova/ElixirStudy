# PHOENIX FRAMEWORK

## Introducción
+ Framework web de Elixir basado en patrón MVC.
+ Componentes:
    + EndPoint:
    + Router: Organiza los request hacia los controllers/actions.
    + Controllers: Maneja los requests en acciones (definidas como funciones).
    + Views: Capa de presentación, que renderiza las plantillas (templates).
    + Templates: Contienen la estructura de la vista que será usada como respuesta.
    + Channels: Manejan sockets para comunicación en tiempo real.
    + PubSub: Permite a los clientes suscribirse a temas.

+ Capas:
    + Phoenix
    + Cowboy: Web server por defecto.
    + Plug: Modulos reusables para acciones como logging.
    + Ecto: El ORM usado en phoenix. Por defecto usa PostgreSQL. Compuesto por:
        + Repository: Representa una conexión a una BD.
        + Schema: Data definitions. Tablas, campos, tipos. Asociación entre recursos.
        + Query: Obtener data.
        + Changeset: Transformaciones antes de usar la data. Como, por ejemplo, casting, validaciones, etc.

## Comenzando con Phoenix
+ Creación de una aplicación: Comando phx.new en el directorio donde se creará seguido del nombre de la aplicación.
    $ mix phx.new hello
+ Es necesario configurar el archivo config/dev.exs con la conexión a la base de datos postgres para usar.
+ Para crear la base de datos en la conexión establecidad se utiliza el comando:
    $ mix ecto.create
+ Iniciar la aplicación:
    $ mix phx.server
    $ iex -S mix phx.server (Desde IEX)

## Agregar una nueva página
+ Dentro de la ruta lib/hello_web/router.ex se encuentra ubicado el router que se encargará de redireccionar las peticiones hacia el controlador/acción que la procesará.
+ Los controladores se encuentran en la ruta lib/hello_web/controllers/ y deben tener el nombre seguido de la palabra Controller, ejemplo HelloController (definición del módulo) - hello_controller.ex (archivo)
+ Las vistas se encuentran en la ruta lib/hello_web/views/ y se deben llamar igualmente con el nombre seguido de view, deben tener el mismo nombre que el controlador que las utiliza.
+ Las plantillas (templates) se encuentran en la ruta lib/hello_web/templates. Al interior de esta se debe crear una carpeta por cada estructura que se maneja (por ejemplo, trabajando con vehiculos se crea un controller para vehículos, una vista para vehículos y una carpeta donde estarán las plantillas de los vehículos para cada acción sobre ellos)

## Routers
+ En la rutas se pueden definir los verbos HTTP GET, POST, PUT, DELETE, OPTIONS, CONNECT, TRACE y HEAD.
+ El comando "mix phx.routes" permite ver las rutas configuradas.
+ resources permite definir para un agrupamiento (ejemplo /users) todos los métodos HTTP por defecto sin escribir una ruta para cada uno. 
    resources "/users", VehicleController
    Esto, agrupa las siguientes rutas:
    + user_path  GET     /users           HelloWeb.UserController :index
    + user_path  GET     /users/:id/edit  HelloWeb.UserController :edit
    + user_path  GET     /users/new       HelloWeb.UserController :new
    + user_path  GET     /users/:id       HelloWeb.UserController :show
    + user_path  POST    /users           HelloWeb.UserController :create
    + user_path  PATCH   /users/:id       HelloWeb.UserController :update
    +         PUT     /users/:id       HelloWeb.UserController :update
    + user_path  DELETE  /users/:id       HelloWeb.UserController :delete
    Si se desea limitar los implementados, se puede limitar con only o except
+ Forward puede ser usado de manera general o dentro de un scope para redireccionar todas las rutas que comiencen por un patrón especificado hacia un plug
    forward "/jobs", BackgroundJob.Plug [, argumentoOpcional]
+ Path Helpers: Usados para obtener las rutas sin necesidad de escribirlas completamente. Están basados en el nombre del módulo y reciben el endpoint y la acción del controlador de cada módulo. 
    Por ejemplo: <a href="<%= page_path(@conn, :index) %>">To the Welcome Page!</a> sería un enlace a la página principal
    La palabra path puede ser cambiada por URL para obtener toda la URL correspondiente
+ Resources anidados representan relación Many-to-One donde el que se encuentra por dentro represente el Many y el más externo el One.
+ Pipelines: las definidas dentro del router son:
    + :browser para las que rutas que se usaran para renderizar en navegadores
    + :api rutas que produciran data para un api

## Plug
Plug es la manera como en Phoenix se distribuye la carga. Pueden ser:
+ **Function Plugs**
Son definidos dentro de una función que acepta un connection struct y opciones. Debe retornar un connection struct
+ **Module Plugs**
El módulo debe implementar dos funciones:
    + init/1: inicializa los argumentos para ser enviados a call/2
    + call/2: Función plug