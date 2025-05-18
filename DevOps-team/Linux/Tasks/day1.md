# Daily Task

## User & Group Management

Create a user devops_user and add them to a group devops_team.

    sudo adduser devops_user
    sudo groupadd devops_team
    sudo usermod -aG devops_team devops_user

Set a password and grant sudo access.

    sudo passwd devops_user
    sudo usermod -aG sudo devops_user        - By adding the user to sudo group

Restrict SSH login for certain users in /etc/ssh/sshd_config

    vim /etc/ssh/sshd_config
    Add the following to the config file: 
    "DenyUsers dev1 dev2"