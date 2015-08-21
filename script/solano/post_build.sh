#!/bin/sh
if [ -z "${TDDIUM_CURRENT_BRANCH##merge_bot_*}" ]; then
  # KEY must match the configured solano.key.
  KEY='06fb52efaae1f06dd2f765cd89cfb12d5931bca2b4607b4cc831d83dbb03ba40'
  test 'passed' = "$TDDIUM_BUILD_STATUS"
  success=$(( 1 - $? ))
  url="https://ci.solanolabs.com/reports/$TDDIUM_SESSION_ID"
  hmac=$(echo -n "$TDDIUM_CURRENT_COMMIT:$success" |\
      openssl dgst -sha256 -hmac $KEY |\
      awk '{print $2}')
  curl 'https://coupa-homu.herokuapp.com/solano' \
      --data-urlencode "commit=$TDDIUM_CURRENT_COMMIT" \
      --data-urlencode "success=$success" \
      --data-urlencode "url=$url" \
      --data-urlencode "hmac=$hmac"
fi
