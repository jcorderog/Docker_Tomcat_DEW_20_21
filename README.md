## Tomcat_IES_Alixar_Curso2021

Dockerfile para el Tomcat usado en el IES Alixar durante el curso 20/21

No se recomienda usar en producción ya que es una imagen creada únicamente con propósitos de docecia.

### Características

    Versión de Tomcat: 9.0.39-jdk11
    Instalación de la aplicación nano
    Habilitación de las aplicaciones de Tomcat: docs, manager y host-manager
    Creación de un usuario tomcat/tomcat que tiene los roles necesarios para la administración del sistema

### Ejecución

Para la puesta en marcha de una instancia de la imagen debemos:

docker run -d -it --rm -p 8888:8080 --name tomcat -v $(pwd)/webapps:/usr/local/tomcat/webapps jcorderog/tomcat
