#!/bin/bash

CONF_DIR="/www/server/nginx/conf/x_cfg"
CONF_CF_REAL_IP_FILE="${CONF_DIR}/cf_realip.conf"
CONF_CF_ALLOW_IP_FILE="${CONF_DIR}/cf_allow_ip.conf"
CONF_CF_MIX_FILE="${CONF_DIR}/cf_ip_check.conf"
CONF_IP_VAR_CONTROL_FILE="${CONF_DIR}/ip_var_allow.conf"

if [ ! -d "${CONF_DIR}"]; then
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

# cf_allow_ip

echo "#Cloudflare" > "${CONF_CF_ALLOW_IP_FILE}";
echo "location / {" >> "${CONF_CF_ALLOW_IP_FILE}";

while IFS= read -r line; do
  echo "    allow $line;" >> "${CONF_CF_ALLOW_IP_FILE}";
done <<< "$CF_IPS"

echo "    deny all;" >> "${CONF_CF_ALLOW_IP_FILE}";
echo "}" >> "${CONF_CF_ALLOW_IP_FILE}";
echo "" >> "${CONF_CF_ALLOW_IP_FILE}";

# cf ip 匹配

echo "#Cloudflare" > "${CONF_CF_MIX_FILE}";
echo "geo \$realip_remote_addr \$is_allow_ip {" >> "${CONF_CF_MIX_FILE}";
echo "    default  0;" >> "${CONF_CF_MIX_FILE}";

while IFS= read -r line; do
  echo "    $line  1;" >> "${CONF_CF_MIX_FILE}";
done <<< "$CF_IPS"

echo "}" >> "${CONF_CF_MIX_FILE}";
echo "" >> "${CONF_CF_MIX_FILE}";

echo ""

# cf ip 验证
echo "#Cloudflare" > "${CONF_IP_VAR_CONTROL_FILE}";
echo "location / {" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "  if (\$is_allow_ip != 1) {" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "    return 403;" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "  }" >> "${CONF_IP_VAR_CONTROL_FILE}";
echo "}" >> "${CONF_IP_VAR_CONTROL_FILE}";

# http 块
# include x_cfg/cf_ip_check.conf;
# server 块
#echo "location / {" >> "${CONF_CF_ALLOW_IP_FILE}";
#echo "if (\$cloudflare_ip != 1) {" >> "${CONF_CF_MIX_FILE}";
#echo "    return 403;" >> "${CONF_CF_MIX_FILE}";
#echo "}" >> "${CONF_CF_MIX_FILE}";
#echo "}" >> "${CONF_CF_MIX_FILE}";
#
#echo "\$realip_remote_addrreal_ip_header CF-Connecting-IP;" >> "${CONF_CF_MIX_FILE}";
#echo "" >> "${CONF_CF_MIX_FILE}";