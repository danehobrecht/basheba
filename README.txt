cd && mkdir google-drive
rclone config
	Google Drive
sudo cp basheba.service /etc/systemd/user/basheba.service
systemctl --user enable basheba.service
systemctl --user start basheba.service
systemctl --user status basheba.service