#!/usr/bin/env bash
# Block obviously dangerous commands even if permissions were mis-set
read -r input
if [[ "$input" =~ rm\ -rf\ (\.|/|\\) ]]; then
echo "Refusing to run blanket rm -rf" >&2
exit 2
fi
exit 0