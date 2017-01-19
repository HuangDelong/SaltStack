include:
  - keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/haproxy-outside-keepalived.conf
    - user: root 
    - group: root
    - mode: 644
    - template: jinja
    {% if grains['fqdn'] == 'node2.srtgsoft.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150
    {% elif grains['fqdn'] == 'node3.srtgsoft.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %}
  service.running:
    - name: keepalived
    - enalble: True
    - watch:
      - file: keepalived-service
