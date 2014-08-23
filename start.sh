#!/bin/bash
sed "s,DIR_FIELD,$1," < config > config.tmp1
sed "s,SECRET_FIELD,$2," < config.tmp1 > config.tmp2
rm config
rm config.tmp1
mv config.tmp2 config
# In case the directory was synced before with another SyncID
rm $1/.SyncID
btsync --config config --nodaemon