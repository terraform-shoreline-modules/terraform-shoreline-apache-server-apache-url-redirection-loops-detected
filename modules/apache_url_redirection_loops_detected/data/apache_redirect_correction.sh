

#!/bin/bash



# Set the variables for the Apache web server root directory and the configuration file

APACHE_DIR=${PATH_TO_APACHE_DIRECTORY}

CONFIG_FILE=${PATH_TO_APACHE_CONFIG_FILE}



# Create a backup of the configuration file before making any changes

cp $CONFIG_FILE $CONFIG_FILE.bak



# Replace all instances of "Redirect 302" with "Redirect 301" in the configuration file

sed -i 's/Redirect 302/Redirect 301/g' $CONFIG_FILE



# Restart the Apache web server to apply the changes

systemctl restart apache2