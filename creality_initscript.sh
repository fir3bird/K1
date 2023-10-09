!# /bin/sh

echo -e "creality\ncreality" | passwd

cd /usr/data
wget -q -O mrngx.tar https://github.com/fir3bird/K1/raw/main/moonraker_nginx.tar
tar -xvf mrngx.tar && rm mrngx.tar
cp moonraker/S56moonraker_service /etc/init.d/S56moonraker_service
cp /usr/data/nginx/S50nginx /etc/init.d/S50nginx
git clone https://github.com/Arksine/moonraker.git moonraker/moonraker
./moonraker/moonraker-env/bin/pip install -r ./moonraker/scripts/moonraker-requirements.txt

wget -q -O mainsail.zip https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip && unzip mainsail.zip && rm mainsail.zip

wget -q -O nginx.conf https://github.com/fir3bird/K1/raw/main/nginx.conf && mv nginx/nginx/nginx.conf nginx/nginx/nginx.conf.bak && cp nginx.conf nginx/nginx/nginx.conf

sed -i 's/[ -x "$BIN_PATH\/$WEB_SERVER" ] && $BIN_PATH\/$WEB_SERVER &/#[ -x "$BIN_PATH\/$WEB_SERVER" ] && $BIN_PATH\/$WEB_SERVER &/g' /etc/init.d/S99start_app

/etc/init.d/S99start_app stop
/etc/init.d/S50nginx start
/etc/init.d/S56moonraker_service start
/etc/init.d/S99start_app start
