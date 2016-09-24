#!/usr/bin/env bash
export _mSettings_DMS_URL=http://localhost:4000
export _mSettings_AGENT_URL=http://localhost:3000
export ROOT_URL=http://localhost
#export PORT=3000   #default 3000

coffee -c *.coffee
npm install
node main.js
