#!/bin/bash

set -e

CONF_DIR="/www/server/nginx/conf/x_cfg"
CONF_CF_REAL_IP_FILE="${CONF_DIR}/cf_realip.conf"
CONF_CF_IP_MAP_FILE="${CONF_DIR}/cf_ip_check.conf"
CONF_IP_VAR_CONTROL_FILE="${CONF_DIR}/ip_var_allow.conf"

NGINX_BIN="/www/server/nginx/sbin/nginx"

if [ ! -d "${CONF_DIR}" ]; then
  mkdir -p "${CONF_DIR}"
fi

CF_IPV4=`curl https://www.cloudflare.com/ips-v4`
CF_IPV6=`curl https://www.cloudflare.com/ips-v6`
CF_IPS=""
CF_IPS+=$CF_IPV4
CF_IPS+=$'\n'
CF_IPS+=$CF_IPV6

# cf_real_ip

echo "#Cloudflare" > "${CONF_CF_REAL_IP_FILE}";

while IFS= read -r line; do
  echo "set_real_ip_from $line;" >> "${CONF_CF_REAL_IP_FILE}";
done <<< "$CF_IPS"

echo "" >> "${CONF_CF_REAL_IP_FILE}";
echo "# use any of the following two" >> "${CONF_CF_REAL_IP_FILE}";
echo "real_ip_header CF-Connecting-IP;" >> "${CONF_CF_REAL_IP_FILE}";
echo "#real_ip_header X-Forwarded-For;" >> "${CONF_CF_REAL_IP_FILE}";

# cf ip map

echo "#Cloudflare" > "${CONF_CF_IP_MAP_FILE}";
echo "geo \$realip_remote_addr \$is_allow_ip {" >> "${CONF_CF_IP_MAP_FILE}";
echo "    default  0;" >> "${CONF_CF_IP_MAP_FILE}";

while IFS= read -r line; do
  echo "    $line  1;" >> "${CONF_CF_IP_MAP_FILE}";
done <<< "$CF_IPS"

echo "}" >> "${CONF_CF_IP_MAP_FILE}";
echo "" >> "${CONF_CF_IP_MAP_FILE}";

echo ""

# cf ip check
echo "#Cloudflare" > "${CONF_IP_VAR_CONTROL_FILE}";
echo "location / {" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "  if (\$is_allow_ip != 1) {" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "    return 403;" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "  }" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "}" >> "${CONF_IP_VAR_CONTROL_FILE}";

# reload

"${NGINX_BIN}" -s reload
