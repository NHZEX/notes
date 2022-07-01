#!/bin/bash
set -e

PHP_VER=8.0
REDIS_VER=5.3.7
#INSTALL_DIR="$(dirname "$0")/.install"
INSTALL_DIR="${HOME}/install"

while getopts 'p:s:' OPT; do
    case ${OPT} in
        p)
            PHP_VER="$OPTARG";;
        s)
            REDIS_VER="$OPTARG";;
        ?)
            echo "Usage: $(basename "$0") -p ${PHP_VER} -s ${REDIS_VER}"
    esac
done

downSwoole () {
    wget -c "https://github.com/phpredis/phpredis/archive/${REDIS_VER}.tar.gz" -O "${REDIS_TAR}"
    sha1sum -b ${REDIS_TAR} > ${REDIS_SUM}
}

REDIS_DIR="${INSTALL_DIR}/redis"
REDIS_TAR="${REDIS_DIR}/v${REDIS_VER}.tar.gz"
REDIS_SUM="${REDIS_DIR}/v${REDIS_VER}.sha1"
REDIS_MAKE_DIR="${REDIS_DIR}/v${REDIS_VER}"
REDIS_INI="20-redis.ini" # /etc/php/${PHP_VER}/cli/conf.d/

PHP_INI_FILE=`php${PHP_VER} -r "echo php_ini_loaded_file();"`
PHP_SCAN_DIR=`php${PHP_VER} -r "echo dirname(substr(@php_ini_scanned_files(), 0, strpos(@php_ini_scanned_files(), ',')));"`

echo "php ver  : ${PHP_VER}"
echo "php ini  : ${PHP_INI_FILE}"
echo "php ini2 : ${PHP_SCAN_DIR}"
echo "swoole   : ${REDIS_VER}"
echo "base dir : ${REDIS_DIR}"
echo "make dir : ${REDIS_MAKE_DIR}"
echo "tar file : ${REDIS_TAR}"
echo "tar sha1 : ${REDIS_SUM}"

rm -r ${REDIS_MAKE_DIR}/* || true
mkdir -p ${REDIS_DIR}
mkdir -p ${REDIS_MAKE_DIR}

if [[ ! -f ${REDIS_TAR} ]] || [[ ! -f ${REDIS_SUM} ]] || [[ ! `sha1sum -c ${REDIS_SUM}` ]]; then
    downSwoole
fi

tar -zxf "${REDIS_TAR}" -C "${REDIS_MAKE_DIR}" --strip-components=1
cd "${REDIS_MAKE_DIR}"

phpize${PHP_VER} --clean
make clean || true

phpize${PHP_VER}
./configure --with-php-config=php-config${PHP_VER} \
    --enable-redis-igbinary

make -j$(nproc)
sudo make install

set +e
php${PHP_VER} --ri redis

if [[ $? -eq 0 ]]; then
    exit 0
fi

if [[ -d ${PHP_SCAN_DIR} ]]; then
    if [[ ! -f ${REDIS_INI} ]]; then
        echo "extension=redis.so" | sudo tee "${PHP_SCAN_DIR}/${REDIS_INI}"
    fi
else
    sudo sed -e '0,/\[PHP\]/ a\\nextension=redis.so\n\n' ${PHP_INI_FILE}
fi

php${PHP_VER} --ri redis
