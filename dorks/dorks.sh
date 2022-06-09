#!/bin/bash
# Enumeration with google Dorks 
# By Dagurasu56

# Variables
## General
example_domain="example.com" 				# Website entry example
sleeptime=6						# Delay between queries
domain=$1 						# Getting domain
browser='Mozilla/5.0_(MSIE;_Windows_11)'	        # Telling the browser in curl
gsite="site:$domain" 					# Google Site

## Login Pages
lpadmin="inurl:admin"
lplogin="inurl:login"
lpadminlogin="inurl:adminlogin"
lpcplogin="inurl:cplogin"
lpweblogin="inurl:weblogin"
lpquicklogin="inurl:quicklogin"
lpwp1="inurl:wp-admin"
lpwp2="inurl:wp-login"
lpportal="inurl:portal"
lpuserportal="inurl:userportal"
lploginpanel="inurl:loginpanel"
lpmemberlogin="inurl:memberlogin"
lpremote="inurl:remote"
lpdashboard="inurl:dashboard"
lpauth="inurl:auth"
lpexc="inurl:exchange"
lpfp="inurl:ForgotPassword"
lptest="inurl:test"
loginpagearray=($lpadmin $lplogin $lpadminlogin $lpcplogin $lpweblogin $lpquicklogin $lpwp1 $lpwp2 $lpportal $lpuserportal $lploginpanel $memberlogin $lpremote $lpdashboard $lpauth $lpexc $lpfp $lptest)

## Filetypes
ftdoc="filetype:doc"						# Filetype DOC (MsWord 97-2003)
ftdocx="filetype:docx"						# Filetype DOCX (MsWord 2007+)
ftxls="filetype:xls"						# Filetype XLS (MsExcel 97-2003)
ftxlsx="filetype:xlsx"						# Filetype XLSX (MsExcel 2007+)
ftppt="filetype:ppt"						# Filetype PPT (MsPowerPoint 97-2003)
ftpptx="filetype:pptx"						# Filetype PPTX (MsPowerPoint 2007+)
ftmdb="filetype:mdb"						# Filetype MDB (Ms Access)
ftpdf="filetype:pdf"						# Filetype PDF
ftsql="filetype:sql"						# Filetype SQL
fttxt="filetype:txt"						# Filetype TXT
ftrtf="filetype:rtf"						# Filetype RTF
ftcsv="filetype:csv"						# Filetype CSV
ftxml="filetype:xml"						# Filetype XML
ftconf="filetype:conf"						# Filetype CONF
ftdat="filetype:dat"						# Filetype DAT
ftini="filetype:ini"						# Filetype INI
ftlog="filetype:log"						# Filetype LOG
ftidrsa="index%20of:id_rsa%20id_rsa.pub"	                # File ID_RSA
filetypesarray=($ftdoc $ftdocx $ftxls $ftxlsx $ftppt $ftpptx $ftmdb $ftpdf $ftsql $fttxt $ftrtf $ftcsv $ftxml $ftconf $ftdat $ftini $ftlog $ftidrsa)

## Directory traversal
dtparent='intitle:%22index%20of%22%20%22parent%20directory%22' 	# Directory path
dtdcim='intitle:%22index%20of%22%20%22DCIM%22' 			# Picture
dtftp='intitle:%22index%20of%22%20%22ftp%22' 			# FTP
dtbackup='intitle:%22index%20of%22%20%22backup%22'		# BackUp
dtmail='intitle:%22index%20of%22%20%22mail%22'			# Mail
dtpassword='intitle:%22index%20of%22%20%22password%22'	# Password
dtpub='intitle:%22index%20of%22%20%22pub%22'			# Pub
dirtravarray=($dtparent $dtdcim $dtftp $dtbackup $dtmail $dtpassword $dtpub)

## Colors
BLACK='\033[30;01;1m'
BLUE='\033[34;01;1m'
CIANO='\033[36;01;1m'
CIANO_BLINK='\033[36;01;05;1m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m' 
RED='\033[31;01;1m'
RED_BLINK='\033[31;01;05;1m'
YELLOW='\033[0;33m'
END='\033[m'

# Header
echo -e "\n "
echo -e "${BLACK}\t██████╗  ██████╗  ██████╗  ██████╗ ██╗     ███████╗    ██████╗  ██████╗ ██████╗ ██╗  ██╗███████╗";
echo -e "${BLACK}\t██╔════╝ ██╔═══██╗██╔═══██╗██╔════╝ ██║     ██╔════╝    ██╔══██╗██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝";
echo -e "${BLACK}\t██║  ███╗██║   ██║██║   ██║██║  ███╗██║     █████╗      ██║  ██║██║   ██║██████╔╝█████╔╝ ███████╗";
echo -e "${YELLOW}\t██║   ██║██║   ██║██║   ██║██║   ██║██║     ██╔══╝      ██║  ██║██║   ██║██╔══██╗██╔═██╗ ╚════██║";
echo -e "${YELLOW}\t╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████╗███████╗    ██████╔╝╚██████╔╝██║  ██║██║  ██╗███████║";
echo -e "${YELLOW}\t ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝";
echo -e "${YELLOW}\t                                         v1.0                                                    ";
echo -e "${YELLOW}\t                                .:Coded by Dagurasu56:.                                          ";

# Verifying Domain
	if [ -z "$domain" ] 
	then
		echo -e "${RED}\t\t\t\t   Example: $0 $example_domain ${END}\n"
		exit
	else
			echo -e "${CIANO}\nGetting information about: $domain ${END}"
			echo -e "${CIANO}Delay between queries: $sleeptime ${END}"
	fi

# Site search function ### START
function Query {
		result="";
		for start in `seq 0 10 40`; # Last number - number of possible answers
			do
				query=$(echo; curl -sS -A $browser "https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e")

				checkban=$(echo $query | grep -io "https://www.google.com/sorry/index")
				if [ "$checkban" == "https://www.google.com/sorry/index" ]
				then 
					echo -e "${RED}Google thinks you are a robot and you have been blocked ;) wait a while to cancel the block or change your ip!${END}"; 
					exit;
				fi
				
				checkdata=$(echo $query | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*$domain/[a-zA-Z0-9./?=_~-]*")
				if [ -z "$checkdata" ]
					then
						sleep $sleeptime; # To avoid blocking
						break;
					else
						result+="$checkdata ";
						sleep $sleeptime; # To avoid blocking
				fi
			done

		# Echo results
		if [ -z "$result" ] 
			then
			           echo -e "\e[00;33m           
			                   ${YELLOW}[${RED}-${RED}${YELLOW}]${END} ${RED}No results${END}"
			else
				IFS=$'\n' sorted=($(sort -u <<<"${result[@]}" | tr " " "\n")) # Single key results
				echo -e " "
				for each in "${sorted[@]}"; do echo -e "    ${GREEN}[${RED}+${GREEN}]${END} $each"; done
		fi

		# Undefined variables
		unset IFS sorted result checkdata checkban query
}
# Site search function ### END

# Function to print the results ### HOME
function PrintTheResults {
	for dirtrav in $@; 
		do echo -en "${GREEN}[${RED}*${END}${GREEN}]${END}" Verifying $(echo $dirtrav | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]' | sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b") "\t" 
		Query $dirtrav 
	done
echo " "
}

# Function to print the results ### FINAL
echo -e "\n${PURPLE}Verifying Login Page:${END}"; PrintTheResults "${loginpagearray[@]}"; > $domain.txt
echo -e "\n${PURPLE}Checking Specific Files:${END}"; PrintTheResults "${filetypesarray[@]}"; >> $domain.txt
echo -e "\n${PURPLE}Checking Directory Path:${END}"; PrintTheResults "${dirtravarray[@]}"; >> $domain.txt