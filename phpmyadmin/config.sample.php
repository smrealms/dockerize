<?php

// Restrict access by IP address
$i = 1;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['socket'] = '/var/run/mysqld/mysqld.sock';
$cfg['Servers'][$i]['AllowDeny']['order'] = 'explicit';
$cfg['Servers'][$i]['AllowDeny']['rules'] = array('allow % from XX.XXX.XXX.XX');
