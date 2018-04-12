#!/usr/bin/env bash
/usr/bin/redis-cli info replication | grep "role\:master" || exit 999
