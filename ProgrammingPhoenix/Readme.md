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

## Chapter 4: Ecto and Changesets
* Ecto permite leer y persistir data en una base de datos relacional como PostgreSQL.
* Contiene un lenguaje de consulta que permite hacer querys elaboradas.
* El Changeset permite almacenar los cambios a realizar en la base de datos, encapsulando el proceso de recibir data externa (como de un formulario web), realizar la conversión a los campos de la base de datos (casting) y validar esa data antes de hacer los cambios. Se puede definir una o varias funciones changeset en un schema, según los requerimientos.
* DATABASE_URL es la variable de ambiente
* *Schema* es el nombre dado a las entidades o modelos. En un schema se definen las propiedades que son los campos en la tabla al igual que el struct de elixir. Cuando una propiedad es *virtual* significa que realmente no existe en la base de datos.
* *Migrations* son utilizadas para modificar la base de datos desde Phoenix. A continuación, los comandos necesarios para crear una migración y hacerla efectiva en la base de datos:
    * mix ecto.gen.migration create_user: Esto crea un archivo con un cambio en la base de datos, dentro de esa función *change* se puede definir las acciones DDL a realizar sobre la base de datos.
    * mix ecto.migrate: Hace efectivos los cambios definidos en la función *change* de las migraciones pendientes.
* Usando *resources* en el *router* permite unificar varias acciones comunes en HTTP. Por lo que tener  es lo mismo que definir todas estas rutas:
    * get "/users", UserController, :index
    * get "/users/:id/edit", UserController, :edit
    * get "/users/new", UserController, :new
    * get "/users/:id", UserController, :show
    * post "/users", UserController, :create
    * patch "/users/:id", UserController, :update
    * put "/users/:id", UserController, :update
    * delete "/users/:id", UserController, :delete
* mix phoenix.routes permite ver todas las rutas configuradas en el archivo router
* La acción *new* permite renderizar un formulario que será utilizado para la creación de un nuevo registro en la base de datos. De esta manera, la acción del formulario que se muestra con nueva será invocar la acción *create* del controller correspondiente. Igual manera funciona con las acciones *edit* y *update*.

## Chapter 5 - Authenticating Users
* Comeonin es una dependencia que se utiliza para hash de contraseñas.
* Creación de un nuevo changeset que permita la encriptacion de la contraseña.
* Una buena opción es tener un changeset genérico que puede ser usado por otro más específicos.

### The anatomy of a Plug
Los plugs pueden ser de dos maneras:
* Module Plugs: para usarlo *plug Plug.Logger*. Debe tener dos funciones:
    * init: Recibe opciones
    * call: Recibe el *conn* y las *options* del init
* Function Plugs para usarlo *plug :function* el nombre de la función como un átomo.

### Request format
El request que se encuentra en el conn contiene la siguiente información:
* *host:* El host de destino de la petición
* *method:* Método HTTP.
* *path_info:* La ruta en una lista. Ej: ["admin","users"].
* *req_headers:* Request headers. Ej: [{"content-type", "text/plain"}]
* *scheme:* El protocolo como un átomo. Ej: :https
Los siguientes campos son vacíos por defecto, a menos que uno los requiera:
* *cookies:* Request cookies + Response cookies
* *params:* Request parámetros

* *assigns:* Mapa definido por el usuario donde puede ingresar la información que desee.
* *halted:* Bandera usada para detener la aplicación, por ejemplo cuando una autenticación es fallida.
* *state:* Estado de la conexión. Ej: :set, :send, etc.
* *resp_body:* Vacío inicialmente, luego contiene el response como un string.
* *resp_cookies:* Cookies del response.
* *resp_headers:* Headers siguiente la especificación HTTP.
* *status:* Código HTTP de la respuesta. Ej: 200-299 exitoso, 300-399 redireccion, 400-499 no encontrado, 500+ para errores.
* *adapter:* Adaptador
* *private:* Mapa para uso de los frameworks

### Writing an Authentication Plug
* Se crea un plug de función. En este caso lo creamos en la carpeta controllers.
* Se agrega en el router el plug dentro del pipeline y se envía el repositorio que es esperado en las opts del init del plugin. Posteriormente puede ser usado en los controllers que estén dentro de este pipeline.
* Para realizar la autenticación en el controller se realiza un Plug como función para facilitar la invocación en las acciones del controlador.
* La funcion de login se crea en el Plug, pero como es una función adicional se llama de la misma manera que una función de cualquier módulo.

### Implementing Login and Logout
* Nuevas rutas
* Nuevo controller de session
* Creación de vista y plantillas para session
* Se agregan nuevas funciones en el plug de auth para login_by_username_and_pass y logout
* Se agrega en la barra de navegación enlaces para Registrar/Login y Logout.

## Chapter 6: Generators and Relationships
La aplicación creada tendrá en total 3 tablas, las cuáles se relacionarán de la siguiente manera:
* Usuarios (User) pueden crear videos (Video), comentar (Annotation) en ellos.
* El proceso de Videos y Annotations será realizado a través de generadores para agilizar el desarrollo.
### Generating Resources
* *mix phx.gen.html:* Crea plantillas HTML sencillas.
    * mix phx.gen.html Models Video videos user_id:references:users url:string title:string description:text
        * El primer parámetro es el contexto, el cuál es como un Service que consume el Repo y sirve de intermediario con el Controller.
        * El segundo es el nombre del módulo
        * El tercero es el nombre del esquema
        * Siguientes campos son las columnas del esquema.
* *mix phx.gen.json:* Realiza lo mismo pero con JSON para RestAPIs.
* Diferencias entre el libro y lo realizado: La versión anterior de Phoenix no requería un contexto mientras que la nueva si, separando las acciones de llamado del repositorio del controlador hacia otra capa.

### Generated Migrations
El comando anterior crea una migración que finalmente se puede ejecutar con mix ecto.migrate. En caso de ocurrir un error (ej: olvidar un campo) se puede realizar mix ecto.rollback para deshacer el cambio.

### Building Relationships
* Ecto.build_assoc: Crear una asociación con un struct definido
* Repo.preload: Carga las relaciones
* Ecto.assoc: Retorna un Ecto.Query
* *def action(conn, _) do* esta función permite definir algo común para todas las acciones de un controlador. Básicamente es un plug interior del controller.
* Se implementa el capítulo 6 del libro manteniendo la clase independiente tipo Service que se crea con la versión 1.3 de Phoenix.

## Chapter 7: Ecto Queries and Constraints
En este capítulo se agregará funcionalidad a la aplicación permitiendo dividir lo videos por categorías.

### Adding Categories
* *mix phx.gen.schema Category categories name:string* Permite crear un schema sin agregar lo referente con Web (Controller, View, Templates)
* *mix ecto.gen.migration add_category_id_to_video* Crea una migración vacía para agregar manualmente los cambios a hacer en base de datos.
* *mix run priv/repo/seeds.exs* El archivo seeds tiene inserts iniciales para la base de datos. Al ser un archivo exs se puede ejecutar como un script de elixir con *mix run*.

### Associating Videos and Categories
Puntos claves en consultas. Teniendo:
    *Repo.all from c in Category,*
    *order_by: c.name*
    *select: {c.name, c.id}*
Explicación:
* *Repo.all* trae todas las filas
* *from* macro que contruye la consulta
* *c in Category* evalúa cada campo
* *order_by: c.name* permite adicionar la clausula order by como en un SQL
* *select: {c.name, c.id}* Campos a obtener
Más consultas:
    *Repo.one(from u in User, where: u.username == ^username)*
* *Repo.one* Espera un solo resultado, si se generan más ocasionaría un error.
* *where: u.username == ^username* es un where tal cual en SQL, el ^ significa que eso es un valor pasado en una variable. Esto permite realizar protección de SQL Injection.
**Operadores que tiene Ecto**
* Comparison operators: == , != , <= , >= , < , >
* Boolean operators: and , or , not
* Inclusion operator: in
* Search functions: like and ilike
* Null check functions: is_nil
* Aggregates: count , avg , sum , min , max
* Date/time intervals: datetime_add , date_add
* General: fragment , field , and type

**Queries with Elixir's Pipe**
También se puede hacer un query con pipes:
    User |>
    select([u], count(u.id)) |>
    where([u], ilike(u.username, ^"j%") or ilike(u.username, ^"c%")) |>
    Repo.one()
Donde cada uno es enlazado al siguiente con la lista [u]. En esto caso, ahí será incrustado el parámetro anterior. Básicamente es hacer la consulta a la inversa que normalmente se realizaría (y en el mismo orden que en una SQL Query).

### Fragments
En Ecto es posible utilizar fragmentos para hacer consultas que no tienen homologación con Ecto. Es decir, ese fragmento de la consulta se escribe directamente en SQL.
    from(u in User,
    where: fragment("lower(username) = ?",
    ^String.downcase(uname)))
En este caso, se está realizando la conversión a minúscula para no tener en cuenta CaseSensitive con una función propia de SQL. Igualmente, se realiza el paso de parámetros de manera segura para evitar SQL Injection.
También el posible ejecutar una consulta SQL completamente:
*Ecto.Adapters.SQL.query(Rumbl.Repo, "SELECT power($1, $2)", [2, 10])*

### Querying Relationships
* Precargando las relaciones de una vez: *Repo.one from(u in User, limit: 1, preload: [:videos])*
* Usando las asociaciones para filtros de where. Se puede hacer con un join:
    Repo.all from u in User,
    join: v in assoc(u, :videos),
    join: c in assoc(v, :category),
    where: c.name == "Comedy",
    select: {u, v}

### Constraints
Terminología importante:
* *constraint* Igual que los de base de datos: Unique, Index, Primary o Foreign Keys.
* *constraint error* Error al violar algún constraint como al intentar insertar dos registros con un mismo valor en un campo Unique.
* *changeset constraint* Constrain agregado a un changeset para poder manejar errores
* *changeset error messages* Error de constrain modificado en el changeset que permite ser más entendible para mostrar en la vista.

* **Validating Unique Data**
*create unique_index(:users, [:username])* permite realizar el unique en la base de datos. Para utilizar el error generado por este constraint se debe adicionar en el changeset la validación.
	def changeset(model, params \\ :empty) do
		model
		|> cast(params, ~w(name username), [])
		|> validate_length(:username, min: 1, max: 20)
		|> unique_constraint(:username)
	end

* **Validating Foreign Keys**
Igualmente, agregar en el changeset el assoc_contraint permite validar las llaves foráneas
	def changeset(model, params \\ :empty) do
		model
		|> cast(params, @required_fields, @optional_fields)
		|> assoc_constraint(:category)
	end
* **On Delete**
Capturar errores al intentar eliminar un registro. Por ejemplo, al intentar borrar un registro que es llave foránea en otras tablas.
	* Se puede controlar primero con el foreign_key_constraint en el changeset el cuál es similar al assoc_contraint
		|> foreign_key_constraint(:post_id) #Esto evaluará los errores de llaves foráneas, como al insertar, actualizar o eliminar.
	* Usar :delete o _nilify en los contrainst para borrar los hijos asociados o volverlos nulo.
* **Let it crash**
Using changeset constraints only makes sense if the error message can be something the user can take action on.

## Chapter 8: Testing MVC
* Principios de pruebas:
	* Fast: Los test corren rápido y concurrentes.
	* Isolated: Ni mucho que no sea útil, ni poco que se muy complejo.
	* DRY (Don't Repeat Yourself): Eliminar repitición innecesaria.
	* Repeatable: Siempre deben mostrar los mismos resultados.
* Tipos de Test:
	* Unit Test: Prueba una función de una capa de la aplicación.
	* Integration Test: Como varias capas funcionan juntas. Normalmente son pruebas sobre los controladores, por ejemplo.
	* Acceptance test case: Toda una prueba funcional. Por ejemplo, iniciar sesión y cerrar sesión posteriormente, es decir, puede combinar varias de integración. *No cubierta en el libro*
	* Performance Test: Como carga la aplicación. *No cubierta en el libro*

### Understanding ExUnit
**ExUnit** es el framework de pruebas de elixir.
* *setup* macro para configuracion
* *test* macro para un caso de prueba
* *assert* macro para verificar si se cumple una condición.
**mix test** permite ejecutar los test case definidos con ExUnit en Phoenix.


%{"name" => "another_user", "password" => test123, "username" => "anon"}

































