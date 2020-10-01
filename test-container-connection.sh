STATUSCODE=$(curl -s -o --head -w "%{http_code}" --data "<?xml version='1.0' encoding='UTF-8'?><methodCall><methodName>version</methodName></methodCall>" http://localhost:8069/xmlrpc/2/common)
if test $STATUSCODE -ne 200; then
  echo $STATUSCODE
  echo $(curl -s -o --data "<?xml version='1.0' encoding='UTF-8'?><methodCall><methodName>version</methodName></methodCall>" http://localhost:8069/xmlrpc/2/common)
  exit 1
fi
