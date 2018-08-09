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

### Going Deeper: The Request Pipeline
**Plug Library**: Cada plug consume y produce una estructura de data común llamada Plug.Conn (contiene todo el *universo* de un request). Cada plug se puede entender como una función individual que recibe el conn, le realiza algún cambio y devuelve el conn modificado.
El pipeline de Phoenix son varios Plug por el cuál el conn pasa y es modificado en cada capa.

### Phoenix File Structure:
Principales directorios:
* **assets:** Donde se almacenan los archivos CSS, JS, Imagenes.
* **config:** Archivos de configuración:
    * config: Archivo principal donde se define cuál es el repositorio, cuál es el endpoint y logs.
    * dev, prod, test: Archivos de los ambientes, se pueden adicionar más. Con la variable MIX_ENV se escoge cuál ambiente, por defecto es DEV.
* **lib:** Árbol de supervisión y procesos.
    * project
    * project_web: endpoint.ex es el archivo que contiene la configuración del endpoint.
* **priv:** Archivos usados por la aplicación, como por ejemplo, las migraciones a base de datos.
* **test:** Archivos de pruebas
* **web:** Archivos relacionados a la parte web (vistas, plantillas, controladores).
Phoenix mantiene la misma estructura básica de un proyecto mix.

### Archivos:
* **ex:** Archivos que son compilados en archivos *beam* y ejecutados en Erlang.
* **exs:** Scripts de elixir, compilados en memoria cada vez que se ejecutan
* **mix.exs:** Archivo que contiene la información del proyecto
* **mix.lock:** Versión específica de las dependencias.
* **lib/project_name.ex:** Archivo principal del proyecto.

## Chapter 3: Controllers, Views, and Templates
### Controllers
Acciones comunes:
* :show
* :index
* :new
* :create
* :edit
* :update
* :delete

### Views
Las vistas permiten definir funciones que permiten a la plantilla mostrar la información como la requiere el usuario. Se puede dejar vacía si no es necesario modificar la información como viene en el modelo o se pueden crear funciones que permitan modificar el modelo y mostrar la información como se quiere (ver la función first_name en la user_view).

### Templates
* Se debe crear una carpeta por cada vista y una template por cada acción.
* Con <%= %> es posible utilizar la información de los parámetros devueltos por la vista, incluso usando las funciones de esta.
* Si se utiliza <% %> Es para ejecutar código sin necesidad de imprimir el resultado en la plantilla.
* for user <- @users do es básicamente un foreach
* link es la manera de crear un elemento <a href> desde código.
* Se pueden utilizar los helpers para hacer el llamado de la URL de una acción sin necesidad de conocer la URL exacta user_path(@conn, :show, user.id) llama la acción *show* del UserController.

### Naming Conventions
Tanto controller como view deben tener el Modulo + Tipo que lo identifica:
UserController <--> UserView
De esta manera se enlaza la vista al controlador. Los templates son enlazados de manera Modulo/Accion de manera que para mostrar el resultado de la acción index del UserController utilizará la plantilla ubicada en templates/user/index.html.eex

### Nesting Template
Se puede centralizar el código repetido de varias plantillas en una sola que es llamada por todas las que lo necesiten. De esta manera, los cambios solo serán necesarios en una única plantilla y actualizados en todas (ver plantilla user.html.eex).

### Layouts
Cuando se llama render desde un controller en realidad primero se construye el layout y se envía a este la vista, la plantilla y los parámetros (lo que es el  return de la acción del controlador) estos son renderizados en el layout en la línea <%= render @view_module, @view_template, assigns %>