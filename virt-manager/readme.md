# Virtual Machine Manager
This is the virtual machine manager to manage libvirt hosts.

# Usage
Since this is a GUI application, you will need to pass the `DISPLAY` environment variable.  If you are using a remote host, you will need to run `xhost +<IP>` to allow access.  If you are running a local xserver you can bind the current socket with `-v /tmp/.X11-unix:/tmp/.X11-unix`.
