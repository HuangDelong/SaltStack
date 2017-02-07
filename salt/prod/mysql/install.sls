pkg-install:
  pkg.installed:
    - names:
      - libaio

mysql-install:
  file.managed:
    - name: /usr/local/src/mysql-5.7.12-linux-glibc2.5-x86_64.tar.gz
    - source: salt://mysql/files/mysql-5.7.12-linux-glibc2.5-x86_64.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: tar xvf /usr/local/src/mysql-5.7.12-linux-glibc2.5-x86_64.tar.gz -C /usr/local/ && cd /usr/local && mv mysql-5.7.12-linux-glibc2.5-x86_64  mysql && groupadd mysql && useradd -r -g mysql -s /bin/false mysql && chown -R mysql:mysql mysql  && chmod -R 755 mysql  &&  /usr/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data
    - unless: test -d /usr/local/mysql
mysql-conf:
  file.managed:  
    - name : /etc/my.cnf
    - source: salt://mysql/files/my.cnf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    {% if grains['fqdn'] == 'web01.srtgsoft.com' %}
    - SERVERID: 8
    {% endif %}
  service.running:
    - name: mysqld
    - enable: True
    - reload: True
    - watch:
      - file: mysql-conf

mysql-service:
  file.managed:
  - name: /etc/init.d/mysqld
  - source: salt://mysql/files/mysqld
  - user: root
  - group: root 
  - mode: 755

mysql-init:
  cmd.run:
    - name: chkconfig --add mysqld
    - unless: chkconfig --list | grep mysqld
    - require:
      - file: /etc/init.d/mysqld

