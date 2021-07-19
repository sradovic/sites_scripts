#!/bin/bash
ssh -q -t -t 172.27.254.78  "sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-base ;
					  sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-osc ;
					  sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-sfdc ;
					  sudo chmod -R 777 /aps/files/quickstart/21.B.patch3/ ;
"
ssh -q -t -t 172.30.254.79  "sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-base ;
					  sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-osc ;
					  sudo mkdir -p /aps/files/quickstart/21.B.patch3/refapp-sfdc ;
					  sudo chmod -R 777 /aps/files/quickstart/21.B.patch3/ ;
"

ssh  -t -t 172.27.12.221 "cd /storage/OPS_refapp_images/base/21B/P3/; sudo chmod 644 *.* "
ssh  -t -t 172.27.12.221 "cd /storage/OPS_refapp_images/osc/21B/P3/; sudo chmod 644 *.* "
ssh  -t -t 172.27.12.221 "cd /storage/OPS_refapp_images/sfdc/21B/P3/; sudo chmod 644 *.* "

ssh  172.27.12.221 "cd /storage/OPS_refapp_images/base/21B/P3/; tar -zcvf - ./*" | ssh  172.27.254.78 "cd /aps/files/quickstart/21.B.patch3/refapp-base; tar -zxvf -"
ssh  172.27.12.221 "cd /storage/OPS_refapp_images/osc/21B/P3/; tar -zcvf - ./*" | ssh  172.27.254.78 "cd /aps/files/quickstart/21.B.patch3/refapp-osc; tar -zxvf -"
ssh  172.27.12.221 "cd /storage/OPS_refapp_images/sfdc/21B/P3/; tar -zcvf - ./*" | ssh  172.27.254.78 "cd /aps/files/quickstart/21.B.patch3/refapp-sfdc; tar -zxvf -"
ssh  172.27.12.221 "cd /storage/OPS_refapp_images/base/21B/P3/; tar -zcvf - ./*" | ssh  172.30.254.79 "cd /aps/files/quickstart/21.B.patch3/refapp-base; tar -zxvf -"
ssh  172.27.12.221 "cd /storage/OPS_refapp_images/osc/21B/P3/; tar -zcvf - ./*" | ssh  172.30.254.79 "cd /aps/files/quickstart/21.B.patch3/refapp-osc; tar -zxvf -"
ssh  172.27.12.221 "cd /storage/OPS_refapp_images/sfdc/21B/P3/; tar -zcvf - ./*" | ssh  172.30.254.79 "cd /aps/files/quickstart/21.B.patch3/refapp-sfdc; tar -zxvf -"
