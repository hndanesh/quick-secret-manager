#!/usr/bin/env bash

get_word(){
  echo $(cat eff_short_wordlist_2_0.txt | grep $(shuf -i 1111-6666 -n 1) | cut -d$'\t' -f2)
}

echo $#

if [[ $# -ne 2 ]]; then
  echo "usage: ./pass.sh <secret_name> <username>"
  exit 1
fi

PASS=""

for I in {1..4}; do
  WORD=$(get_word)
  while [[ -z "${WORD}" ]]; do
    WORD=$(get_word)
  done
  PASS+="${WORD}-"
done

echo $2 > $1
echo ${PASS::-1} >> $1

gpg2 --encrypt -r 22D41209 $1
[[ -f $1.gpg ]] || echo "encryption failed..."
rm $1
