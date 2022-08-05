#!/bin/bash
set -e

echo "tempuser:x:$(id -u):$(id -g):,,,:${HOME}:/bin/bash" >> /etc/passwd
echo "tempuser:x:$(id -G | cut -d' ' -f 2)" >> /etc/group

# Expand the variables
eval "echo \"$(cat /runner/env/settings)\"" > /runner/env/settings

$1 $2