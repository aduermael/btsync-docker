#!/bin/bash
sed "s,DIR_FIELD,$1," < config > config.tmp1
sed "s,SECRET_FIELD,$2," < config.tmp1 > config.tmp2
rm config
rm config.tmp1
mv config.tmp2 config
btsync --config config --nodaemon