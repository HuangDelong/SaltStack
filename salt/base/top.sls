base:
  '*':
    - init.env_init

prod:
  '*':  
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived 
