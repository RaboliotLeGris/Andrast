#!/usr/bin/env bash

# How it work :
# create -> To create a new Certificate
# fingerprint -> To get the fingerprint for the LB

function createCert {
  # Generate a private key
  openssl genrsa -out server.key 2048
  # Certificate Signing Request
  openssl req -new -key server.key -out server.csr

  #We modify our private key with RSA
  cp server.key private.server.key
  openssl rsa -in private.server.key -out server.key
  #Creating the certificate
  openssl x509 -req -days 1 -in server.csr -signkey server.key -out server.crt
}

function getCert {
  #Get Fingerprint that
  openssl x509 -noout -fingerprint -sha1 -inform pem -in server.crt
}

if [ -z ${1+x} ]; then
  echo "No param set  -> doing nothing";
  echo "Type : create -> To create a new certificate"
  echo "       fingerprint -> To get the fingerprint of the certificate"
elif [ "$1" == 'create' ]; then
  createCert
elif [ "$1" == 'fingerprint' ]; then
  getCert
fi

