#!/bin/bash
DEST_SITE=$1
SUDO="sudo -i";
declare -r g_dir="$(pwd)";
g_components="${g_dir}/components";
g_encrypt_dir="${g_components}/encrypt/1.0.0";
upgrademaps="components/maps"


active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $DEST_SITE "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"


g_editionName=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${DEST_SITE}  " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" cat /bigmac/cpq/bigmachines/WEB-INF/src/sql/oracle/editions/editionVersion.properties | grep editionName | cut -d '=' -f2 \" || exit 1") || return 1;
g_editionName="${g_editionName%%[[:cntrl:]]}"


if echo "$g_editionName" | grep "No such file or directory" ; then
  echo ""
  echo " $DEST_SITE is on version with no edition."
else
  echo ""
  echo "Edition of $DEST_SITE is $g_editionName"
fi

dst_db_user=`ssh $SSHOPTS ${DEST_SITE} "grep ^db_user /bmfs/cpqShared/conf/database.properties | cut -f2 -d="`
dst_db_passwd=`ssh $SSHOPTS ${DEST_SITE} "grep ^db_pass /bmfs/cpqShared/conf/database.properties | cut -f2 -d="`
dbmap_key=${dst_db_user}

g_db_cpquserpass=$(java -jar ${g_encrypt_dir}/encrypt.jar AES decrypt ${dst_db_passwd})
dbhost_mapped=$(grep -v ^# ${upgrademaps}/site.map | grep -i "^\<${dbmap_key}\>" | head -1 | awk '{print $2}') || return 1;
dbsid_mapped=$(grep -v ^# ${upgrademaps}/site.map | grep -i "^\<${dbmap_key}\>" | head -1 | awk '{print $5}') || return 1;

 echo ""
 echo "dbhost ip:  $dbhost_mapped"
 echo "dbsid:  $dbsid_mapped"
 echo "db user:  $dst_db_user"
 echo ""

if echo "$g_editionName" | grep "No such file or directory" ; then 
  ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t  $dbhost_mapped  "[[ -f /usr/local/bin/oraenv ]] && source /usr/local/bin/oraenv -s <<<\"${dbsid_mapped}\" ; sqlplus $dst_db_user/$g_db_cpquserpass <<-EOF
SELECT id, status, category,to_char (execution_time,'YYYY-MM-DD HH24:MI:SS') XQ from bm_task where status not in (4,5,8) and category<>6 order by XQ desc;
EOF
"
else
  ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t  $dbhost_mapped  "[[ -f /usr/local/bin/oraenv ]] && source /usr/local/bin/oraenv -s <<<\"${dbsid_mapped}\"; export ORA_EDITION="$g_editionName"; sqlplus $dst_db_user/$g_db_cpquserpass <<-EOF
set linesize 260
set pagesize 1000
column id format 99999999999999999
column status format 99999
column category format 9999999999
SELECT id, status, category,to_char (execution_time,'YYYY-MM-DD HH24:MI:SS') XQ from bm_task where status not in (4,5,8) and category<>6 order by XQ desc;
EOF
"
fi
