tomcat-install8080:
  file.managed:
    - name: /usr/local/src/apache-tomcat-8.5.11.tar.gz
    - source: salt://tomcat/files/apache-tomcat-8.5.11.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: tar xvf /usr/local/src/apache-tomcat-8.5.11.tar.gz -C /usr/local/  && mv /usr/local/apache-tomcat-8.5.11 /usr/local/tomcat8080 && chmod -R 755 /usr/local/tomcat8080
    - unless: test -d /usr/local/tomcat8080

/usr/local/tomcat8080/conf/server.xml:
  file.managed:
    - source: salt://tomcat/files/server8080.xml
    - user: root
    - group: root
    - mode: 755

