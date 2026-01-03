# KRANUS.GRUB
Między galaktyczny grub w twoim komputerze, cieplutko wyjechał z kuźni babilon!!!

## Instalacja 

1. Pobierz se
``` bash
git clone https://github.com/kacpereqo/KRANUS.GRUB
sudo mkdir -p /boot/grub/themes
sudo cp -r ~/Downloads/KRANUS.GRUB /boot/grub/themes/
```
2. Edytuj dziada
   
```
sudo nano /etc/default/grub
```

  Wklej to
  `GRUB_THEME="/boot/grub/themes/KRANUS.PRO/theme.txt"`
  
3. Zrestartuj gruba
```bash 
sudo update-grub
```
