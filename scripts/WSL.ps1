choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"

wsl --install

RefreshEnv

Ubuntu2204 install --root
Ubuntu2204 run apt update
Ubuntu2204 run apt upgrade -y
