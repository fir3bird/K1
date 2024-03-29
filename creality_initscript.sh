!#/bin/sh

echo -e "creality\ncreality" | passwd

cd /usr/data
wget --no-check-certificate -q -O mrngx.tar https://github.com/fir3bird/K1/raw/main/moonraker_nginx.tar && tar -xf mrngx.tar && rm mrngx.tar
cp -f moonraker/S56moonraker_service /etc/init.d/S56moonraker_service
cp -f /usr/data/nginx/S50nginx /etc/init.d/S50nginx
mkdir moonraker -p && cd moonraker && git clone https://github.com/Arksine/moonraker.git moonraker
./moonraker/moonraker-env/bin/pip install -r ./moonraker/scripts/moonraker-requirements.txt

cd /usr/data
mkdir mainsail -p && cd mainsail
wget --no-check-certificate -q -O mainsail.zip https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip && unzip mainsail.zip && rm mainsail.zip

cd /usr/data
wget --no-check-certificate -q -O moonraker.conf https://github.com/fir3bird/K1/raw/main/moonraker.conf && mv moonraker.conf moonraker/moonraker/moonraker.conf
wget --no-check-certificate -q -O nginx.conf https://github.com/fir3bird/K1/raw/main/nginx.conf && mv nginx/nginx/nginx.conf nginx/nginx/nginx.conf.bak && cp nginx.conf nginx/nginx/nginx.conf

sed -i 's/\[ -x "\$BIN_PATH\/\$WEB_SERVER" \] && \$BIN_PATH\/\$WEB_SERVER &/#\[ -x "\$BIN_PATH\/\$WEB_SERVER" \] \&\& \$BIN_PATH\/\$WEB_SERVER \&/g' /etc/init.d/S99start_app
sed -i 's/copy_config/#copy_config/g' /etc/init.d/S55klipper_service && sed -i 's/#copy_config()/copy_config()/g' /etc/init.d/S55klipper_service

/etc/init.d/S99start_app stop
/etc/init.d/S50nginx start
/etc/init.d/S56moonraker_service start
/etc/init.d/S99start_app start
