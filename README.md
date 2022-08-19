# Reto 5

Este es un pequeño ejercicio de consola en Ruby hecho para la plataforma [Make It Real](https://www.makeitreal.camp/subjects/ruby/projects/3):

> El objetivo del juego es que un usuario pueda ingresar la respuesta a cada pregunta que le vamos haciendo y que el juego le responda si la respuesta fue correcta o no. En caso de que si sea correcta seguimos con una nueva pregunta, en caso de que no le indicamos al usuario que vuelva a intentar ingresando una nueva respuesta.

## Instalar

* El repositorio puede ser clonado usando `git clone https://github.com/alejsalaz/Reto-5.git`.
* Es necesario instalar la gema _colorize_ usando `gem install colorize`.

El ejecutable se encuentra en el  directorio [bin/reto.rb](bin/reto.rb).

## Jugar

Al ejecutar el archivo de la ruta [bin/reto.rb](bin/reto.rb) tendrás la opción de iniciar un nuevo juego o entrar a modificar las preguntas.Al escoger comenzar el juego tienes <u>tres vidas</u>, pierdes el juego si tus vidas se terminan y lo ganas contestando un máximo de <u>10 preguntas</u> de forma acertada, las preguntas son de opción múltiple.

Al finalizar el juego tu puntaje base quedará de la siguiente forma:

| **Puntaje** | **Vidas** |
|:-----------:|:---------:|
| 100         | 5         |
| 50          | 4         |
| 25          | 3         |
| 12          | 2         |
| 6           | 1         |
| 0           | 0         |

---

**Nota:** Por cada pregunta que contestes correctamente sumarás <u>25 puntos</u> extra.

## Modificar

El juego utiliza las preguntas localizadas en el en el  directorio [app/model/questions.txt](app/model/questions.txt), de querer cambiar las preguntas se debe modificar el archivo manualmente o de forma gráfica corriendo el archivo de [bin/reto.rb](bin/reto.rb) teniendo en cuenta lo siguiente:

1. Las preguntas deben ser cortas y se deben localizar en las líneas impares.
2. Las opciones de respuesta deben ser de máximo 58 caracteres, cada una debe ir separada por una barra vertical y la primera respuesta debe ser la respuesta correcta.

Ejemplo:

> 1. ¿Esta es una pregunta?
> 2. Sí | No
> 3. ¿El tres es un número par?
> 4. No | Sí
