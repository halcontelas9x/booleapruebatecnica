# Prueba Técnica Boolea!

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/modules/trailhead-in-your-language/233ac5fec8fcb30f9eb6091afc2ee200_badge.png)

  



Bienvenido a este repositorio! En él, se encuentra la solución presentada por Héctor Martínez para la casuística presentada en el documento de [requisitos](https://github.com/halcontelas9x/booleapruebatecnica/blob/main/requisitos/Prueba%20te%CC%81cnica%20Senior%20-%20Requisitos.pdf) facilitado por la empresa Boolea.

  

## Accesos

  

Se ha creado un playground donde se han desplegado todos los componentes necesarios.

Acceso al playground desde el siguiente enlace [playground](https://cunning-shark-b4gvmq-dev-ed.trailblaze.my.salesforce.com/) y con los siguientes datos:
 ~~~
U: halcon.telas9x@cunning-shark-b4gvmq.com

P: telas9halcon
~~~

También se ha creado un git para almacenar todo el código. Accesible desde este enlace

https://github.com/halcontelas9x/booleapruebatecnica

Se ha creado una rama de develop donde [estan los commits del desarrollo](https://github.com/halcontelas9x/booleapruebatecnica/activity?ref=feature/develop) y luego se ha mergeado con la rama [main](https://github.com/halcontelas9x/booleapruebatecnica) para dejarlo terminado.
  

## Pasos Despliegue


Una vez desplegado el archivo [base-prueba-tecnica.xml](https://github.com/halcontelas9x/booleapruebatecnica/blob/main/manifest/base-prueba-tecnica.xml) en el nuevo playground, se ha de añadir al usuario administrador, en este caso Hector Martinez (Hmar), el permissionSet y el permissionSetGroup especificados en el fichero, SupportAdmin y Admins respectivamente. Con esto ya tenemos permisos para añadir la nueva tab a la app de Sales por ejemplo, que es donde está actualmente.

El archivo [solucion-prueba-tecnica.xml](https://github.com/halcontelas9x/booleapruebatecnica/blob/main/manifest/solucion-prueba-tecnica.xml) lleva todo lo necesario para ser desplegado en una playground nueva o en una sandbox 

Una vez desplegado el archivo de solucion en el playground, sera necesario acceder a la app de Sales y editar el menu para añadir el Navigation Item para poder acceder al Custom Object.

  

## Automatización

Se crea un schedule para lanzar el batch que actualizará los SupportRequest que están en los estados indicados cada día a las 12 de la noche.

Para su configuración ha sido necesario crear la automatización de la siguiente manera (en la consola de desarrollador 'Anonymous Apex')
 

~~~
String nombreJob = 'SupportResquest_Medianoche';
String cron = '0 0 0 * * ?';

System.schedule(nombreJob, cron, new SupportRequestSchedule());

~~~


# Observaciones finales a la prueba

  

En el enunciado se indica que tienen que ser tres sistemas diferenciados y puede llevar a equívoco ya que se puede interpretar que son tres sistemas distintos. Yo por ejemplo llegue a pensar que debería ser por ejemplo con un Flow, un Trigger y un Batch, pero también se puede entender como tres procesos pero por el mismo sistema.
