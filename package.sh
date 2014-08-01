#! /bin/bash
vagrant up
vagrant halt
tar -zcvf images.tar.gz images.vdi
#vagrant destroy -f
#sftp PMX@panamax.ingest.cdn.level3.net
