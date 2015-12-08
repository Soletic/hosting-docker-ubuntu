#!/bin/bash

env |cat - /etc/crontab > /tmp/crontab
mv /tmp/crontab /etc/crontab

exec supervisord -n