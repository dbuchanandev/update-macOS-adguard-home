# Download latest macOS release
FILE=AdGuardHome_darwin_amd64.zip
TMP=/tmp/$FILE
curl -L -S -o $TMP -s https://static.adtidy.org/adguardhome/release/$FILE

# Stop AdGuard Home
sudo /Applications/AdGuardHome/AdGuardHome -s stop

# Backup data
DATE=`date`
BACKUP_DIR="/Applications/AdGuardHome/agh-backups/$DATE"
mkdir -p "$BACKUP_DIR"
cp -r /Applications/AdGuardHome/AdGuardHome.yaml /Applications/AdGuardHome/data "$BACKUP_DIR"

# Unpack downloaded release
unzip -o $TMP -d /tmp/

# Replace old files
sudo cp /tmp/AdGuardHome/AdGuardHome /Applications/AdGuardHome/AdGuardHome
sudo cp /tmp/AdGuardHome/LICENSE.txt /Applications/AdGuardHome/
sudo cp /tmp/AdGuardHome/AdGuardHome.sig /Applications/AdGuardHome/
sudo cp /tmp/AdGuardHome/README.md /Applications/AdGuardHome/
sudo cp /tmp/AdGuardHome/CHANGELOG.md /Applications/AdGuardHome/

# make executable
sudo chmod +x /Applications/AdGuardHome/AdGuardHome

# Restart AdGuard Home
sudo /Applications/AdGuardHome/AdGuardHome -s start

# cleanup tmp files
rm -rf /tmp/AdGuardHome
rm $TMP
