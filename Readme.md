# Repositorio personal de estudio de Elixir
**Basado en libro Introducing Elixir - Simon St. Laurent & J. David Eisenberg**
##Capítulo 1 - Introduccion:
+ Lenguaje funcional basado en Erlang. Por lo anterior, la compilación de un archivo elixir produce un archivo .beam de Erlang
+ Es necesario tener instalado Erlang, que realiza la misma tarea de máquina virtual como la JVM o .NET Framework en otros lenguajes.


##Capítulo 2 - Módulos y funciones:
+ **Módulo:** Mismo concepto de clases en otros lenguajes como Java
+ **Función:** Mismo concepto de métodos en otros lenguajes como Java
+ **ex:**  Extension de un modulo en elixir
+ **c(module_file):** Comando de elixir para compilar
+ **exs:** Archivo que contiene varios comandos de elixir para ser ejecutados en una sola línea
+ **drop.ex:** Archivo que contienen un ejemplo basico de creacion de modulo con funciones públicas y privadas

##Capítulo 3 - Atoms, Tupples and Pattern Matching
+ **Atom:** Una especia de variable definida por los ":" con un nombre, el valor que guarda es el mismo nombre. Ver la implementación realizada sobre las funciones del módulo drop. Pueden contener en su nombre "_" o "@".
+ **Guards:** Añadir una condición para ejecutar una función, evitando errores.
