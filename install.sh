#!/bin/bash

# Zmienne
REPO_URL="https://github.com/kacpereqo/KRANUS.GRUB"
THEME_DIR="/boot/grub/themes"
THEME_NAME="KRANUS.GRUB"
GRUB_CFG="/etc/default/grub"

# 1. Sprawdzenie czy skrypt jest uruchomiony jako root
if [ "$EUID" -ne 0 ]; then
  echo "Proszę uruchomić jako root (sudo ./install.sh)"
  exit 1
fi

echo "--- Rozpoczynanie instalacji KRANUS.GRUB ---"

# 2. Pobieranie (Clean up old folder if exists locally)
echo "[1/4] Pobieranie repozytorium..."
if [ -d "$THEME_NAME" ]; then
    rm -rf "$THEME_NAME"
fi

if git clone "$REPO_URL"; then
    echo "Pobrano pomyślnie."
else
    echo "Błąd pobierania. Sprawdź połączenie z internetem lub czy git jest zainstalowany."
    exit 1
fi

# 3. Instalacja plików
echo "[2/4] Kopiowanie plików do $THEME_DIR..."
mkdir -p "$THEME_DIR"

# Jeśli stary folder motywu już tam jest, usuń go, żeby wgrać świeżą wersję
if [ -d "$THEME_DIR/$THEME_NAME" ]; then
    rm -rf "$THEME_DIR/$THEME_NAME"
fi

cp -r "$THEME_NAME" "$THEME_DIR/"

# 4. Edycja /etc/default/grub
echo "[3/4] Edycja konfiguracji GRUB..."

# Kopia zapasowa oryginalnego pliku
cp "$GRUB_CFG" "${GRUB_CFG}.bak"
echo "Utworzono kopię zapasową: ${GRUB_CFG}.bak"

# Usunięcie starej linii GRUB_THEME (jeśli istnieje) i dodanie nowej
sed -i '/^GRUB_THEME=/d' "$GRUB_CFG"
echo "GRUB_THEME=\"$THEME_DIR/$THEME_NAME/theme.txt\"" >> "$GRUB_CFG"

# 5. Aktualizacja GRUBa
echo "[4/4] Aktualizacja bootloadera..."

if command -v update-grub &> /dev/null; then
    update-grub
elif command -v grub-mkconfig &> /dev/null; then
    # Alternatywa dla systemów bez update-grub (np. Arch/Fedora)
    grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "Nie znaleziono komendy 'update-grub'. Zaktualizuj GRUB ręcznie."
    exit 1
fi

# Sprzątanie pobranego folderu lokalnego
rm -rf "$THEME_NAME"

echo "--- Gotowe! Zrestartuj komputer, aby zobaczyć efekty. ---"
