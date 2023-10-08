!# /bin/sh

echo -e "creality\ncreality" | passwd

cd /usr/data
cp moonraker/S56moonraker_service /etc/init.d/S56moonraker_service
cp /usr/data/nginx/S50nginx /etc/init.d/S50nginx
mv moonraker/ moonraker.bak/
git clone https://github.com/Arksine/moonraker.git moonraker
./moonraker-env/bin/pip install -r ./moonraker/scripts/moonraker-requirements.txt

wget -q -O mainsail.zip https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip && unzip mainsail.zip && rm mainsail.zip

