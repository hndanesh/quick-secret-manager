#!/usr/bin/env bash
gpg2 --decrypt $1 | tail -1 > /dev/clipboard
