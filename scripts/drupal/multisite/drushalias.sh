#!/usr/bin/sh

sudo cat >> "~/.drush/nittany.aliases.drushrc.php" <<- EOF
  \$aliases['$sitedir'] = array(
      'root' => '/var/www/html/$sitedir'
      'uri' => 'http://$sitedir.psudug.dev'
  );
EOF
