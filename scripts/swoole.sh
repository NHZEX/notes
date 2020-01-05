#!/bin/bash
set -e

PHP_VER=7.3
SWOOLE_VER=4.4.14
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

echo "php      : ${PHP_VER}"
echo "swoole   : ${SWOOLE_VER}"

SWOOLE_DIR="${INSTALL_DIR}/swoole"
SWOOLE_TAR="${SWOOLE_DIR}/v${SWOOLE_VER}.tar.gz"
SWOOLE_SUM="${SWOOLE_DIR}/v${SWOOLE_VER}.sha1"
SWOOLE_MAKE_DIR="${SWOOLE_DIR}/v${SWOOLE_VER}"
SWOOLE_INI="/etc/php/${PHP_VER}/cli/conf.d/30-swoole.ini"

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
    --enable-sockets \
    --enable-openssl \
    --enable-mysqlnd \
    --enable-sockets

make -j$(nproc)
sudo make install

if [[ ! -f ${SWOOLE_INI} ]]; then
    echo "extension=swoole.so" | sudo tee ${SWOOLE_INI}
fi
