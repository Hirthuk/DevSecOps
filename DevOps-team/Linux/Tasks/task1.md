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

    sudo vim /etc/ssh/sshd_config
    Add the following to the config file: 
    "DenyUsers testuser"
    "AllowUsers devops_user ubuntu"

Verify the user was created successfully:

    id devops_user
    grep devops_user /etc/passwd
    grep devops_team /etc/group

Verify sudo access:

    su devops_user
    whoami -> root so it is sudo user
    or check groups devops_user - user presnet inside sudo group

Verify SSH restrictions:

    ssh testuser@server_IP        - Should be denied
    ssh devops_user@server_IP     - Should be allowed configure ssh key

Apply SSH config changes:

    sudo systemctl restart sshd
    sudo sshd -t                  - Validate config syntax


Troubleshooting notes:
- Always use 'sudo' when modifying system files
- Users must log out and back in for group changes to take effect
- SSH changes require service restart to apply
- Check /var/log/auth.log if SSH access isn't working as expected