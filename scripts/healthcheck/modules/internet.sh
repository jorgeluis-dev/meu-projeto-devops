#!/bin/bash

#Internet: o ping respondeu?

if ping -c 1 ubuntu.com > /dev/null 2>&1; then
	echo "[OK] Internet"
else
	echo "[FALHA] Internet"
fi

