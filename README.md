# KRANUS.GRUB
Między galaktyczny grub w twoim komputerze, cieplutko wyjechał z kuźni babilon!!!

## Instalacja

1. Pobierz se
``` bash
git clone https://github.com/kacpereqo/KRANUS.GRUB
```

1.1 Opcjonalne - Uruchom `install.sh`


2. Kopiuj cudaki
```
sudo mkdir -p /boot/grub/themes
sudo cp -r KRANUS.GRUB /boot/grub/themes/
```
3. Edytuj dziada
   
```
sudo nano /etc/default/grub
```

  Wklej to
  `GRUB_THEME="/boot/grub/themes/KRANUS.GRUB/theme.txt"`
  
4. Zrestartuj gruba
```bash 
sudo update-grub
```
