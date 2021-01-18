FROM tomcat:9.0.39-jdk11

# Installing basic tools
RUN apt update && apt install -y nano && apt install -y  vim && apt install -y openssh-server

# Enable manager app, host manager app and docs apss
RUN mv /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
RUN rm -rf /usr/local/tomcat/webapps.dist

# Copying my tomcat-users.xml to the container
# TO-BE-DONE user password as a docker build arg
COPY mytomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

# Context Modifying from all default apps
COPY mycontext.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY mycontext.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Copiamos la configuración
COPY ./ssh/sshd_config /ect/ssh/sshd_config
COPY ./ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY ./ssh/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
COPY ./ssh/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ./ssh/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ./ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
COPY ./ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub

# Creamos el usuario necesario y le asignamos una contraseña
RUN useradd -rm -d /home/pruebaSSH -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'pruebaSSH:prueba' | chpasswd

# Iniciamos el servicio
RUN service ssh start
