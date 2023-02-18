rclone config
sudo pacman -S cronie
sudo systemctl enable cronie
sudo systemctl start cronie
sudo VISUAL=nano crontab -e
	@reboot /home/user/path/to/basheba.sh