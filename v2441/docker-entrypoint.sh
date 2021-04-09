#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for dynamicd"

  set -- dynamicd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "dynamicd" ]; then
  mkdir -p "$DYNAMIC_DATA"
  chmod 700 "$DYNAMIC_DATA"
  chown -R dynamic "$DYNAMIC_DATA"

  echo "$0: setting data directory to $DYNAMIC_DATA"

  set -- "$@" -datadir="$DYNAMIC_DATA"
fi

if [ "$1" = "dynamicd" ] || [ "$1" = "dynamic-cli" ] || [ "$1" = "dynamic-tx" ]; then
  echo
  exec gosu dynamic "$@"
fi

echo
exec "$@"