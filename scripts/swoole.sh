#!/bin/bash
set -e

PHP_VER=7.3
SWOOLE_VER=4.4.17
#INSTALL_DIR="$(dirname "$0")/.install"
INSTALL_DIR="${HOME}/install"

while getopts 'p:s:' OPT; do
    case ${OPT} in
        p)
            PHP_VER="$OPTARG";;
        s)
            SWOOLE_VER="$OPTARG";;
        ?)
            echo "Usage: $(basename "$0") -p ${PHP_VER} -s ${SWOOLE_VER}"
    esac
done

downSwoole () {
    wget -c "https://github.com/swoole/swoole-src/archive/v${SWOOLE_VER}.tar.gz" -O "${SWOOLE_TAR}"
    sha1sum -b ${SWOOLE_TAR} > ${SWOOLE_SUM}
}

SWOOLE_DIR="${INSTALL_DIR}/swoole"
SWOOLE_TAR="${SWOOLE_DIR}/v${SWOOLE_VER}.tar.gz"
SWOOLE_SUM="${SWOOLE_DIR}/v${SWOOLE_VER}.sha1"
SWOOLE_MAKE_DIR="${SWOOLE_DIR}/v${SWOOLE_VER}"
SWOOLE_INI="30-swoole.ini" # /etc/php/${PHP_VER}/cli/conf.d/

PHP_INI_FILE=`php${PHP_VER} -r "echo php_ini_loaded_file();"`
PHP_SCAN_DIR=`php${PHP_VER} -r "echo dirname(substr(@php_ini_scanned_files(), 0, strpos(@php_ini_scanned_files(), ',')));"`

echo "php ver  : ${PHP_VER}"
echo "php ini  : ${PHP_INI_FILE}"
echo "php ini2 : ${PHP_SCAN_DIR}"
echo "swoole   : ${SWOOLE_VER}"
echo "base dir : ${SWOOLE_DIR}"
echo "make dir : ${SWOOLE_MAKE_DIR}"
echo "tar file : ${SWOOLE_TAR}"
echo "tar sha1 : ${SWOOLE_SUM}"

mkdir -p ${SWOOLE_DIR}
mkdir -p ${SWOOLE_MAKE_DIR}

if [[ ! -f ${SWOOLE_TAR} ]] || [[ ! -f ${SWOOLE_SUM} ]] || [[ ! `sha1sum -c ${SWOOLE_SUM}` ]]; then
    downSwoole
fi

tar -zxf ${SWOOLE_TAR} -C ${SWOOLE_MAKE_DIR} --strip-components=1
cd ${SWOOLE_MAKE_DIR}

phpize${PHP_VER} --clean
make clean || true

phpize${PHP_VER}
./configure --with-php-config=php-config${PHP_VER} \
    --enable-openssl \
    --enable-http2 \
    --enable-mysqlnd \
    --enable-sockets

make -j$(nproc)
sudo make install

set +e
php${PHP_VER} --ri swoole

if [[ $? -eq 0 ]]; then
    exit 0
fi

if [[ -d ${PHP_SCAN_DIR} ]]; then
    if [[ ! -f ${SWOOLE_INI} ]]; then
        echo "extension=swoole.so" | sudo tee "${PHP_SCAN_DIR}/${SWOOLE_INI}"
    fi
else
    sudo sed -e '0,/\[PHP\]/ a\\nextension=swoole.so\n\n' ${PHP_INI_FILE}
fi

php${PHP_VER} --ri swoole
