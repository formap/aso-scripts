#!/bin/bash

echo `netstat -i | tail -n +3 | awk '{print $1 ":    " $8}'`
