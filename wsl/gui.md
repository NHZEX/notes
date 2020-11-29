### X11
Link: https://medium.com/@japheth.yates/the-complete-wsl2-gui-setup-2582828f4577

```
sudo apt install build-essential
sudo apt install net-tools
sudo apt install xrdp -y && sudo systemctl enable xrdp

sudo apt install -y tasksel
sudo tasksel install xubuntu-desktop
sudo apt install gtk2-engines
```
nano ~/.bashrc
```
export DISPLAY=$(ip route show 0.0.0.0/0 | awk '{print $3}'):5123.0
export LIBGL_ALWAYS_INDIRECT=1
sudo /etc/init.d/dbus start &> /dev/null
```
```
your_user_name ALL = (root) NOPASSWD: /etc/init.d/dbus
```
Setting up X-server on Windows 10
```
firefox &
```