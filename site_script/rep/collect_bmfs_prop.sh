#!/bin/bash
DATE=`date "+%m%d%Y"`
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " sudo cp  /bmfs/cpqShared/conf/application.properties  /fsnhome/sradovic/bmfs_properties/prod27/${SHORT_SITENAME}_application.properties_${DATE};
                                                                        sudo cp  /bmfs/cpqShared/conf/server.properties  /fsnhome/sradovic/bmfs_properties/prod27/${SHORT_SITENAME}_server.properties_${DATE};
                                                                        sudo cp  /bmfs/cpqShared/conf/implementation.properties  /fsnhome/sradovic/bmfs_properties/prod27/${SHORT_SITENAME}_implementation.properties_${DATE};
                                                                        sudo cp  /bmfs/cpqShared/conf/database.properties  /fsnhome/sradovic/bmfs_properties/prod27/${SHORT_SITENAME}_database.properties_${DATE}; 
"
