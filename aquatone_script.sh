#!/bin/bash

# help function
function show_help() {
    echo "Usage: aquatone_script.sh example.com"
    echo ""
    echo "Options:"
    echo "  -h       Show this help message and exit"
    echo ""
    echo "Description:"
    echo "  1. The subdomains will be collected and stored in aquatone_script_result/<domain>/recon/subdomains.txt."
    echo "  2. Using the Aquatone tool, screenshots and reports will be generated in aquatone_script_result/<domain>/recon/aquatone_output/ folder."
    echo "  3. After the process is completed, the report will automatically open in the Firefox browser."
    echo " ************** Thanks by Admas *************** "
    echo " Note : You will find the subdomain report and screenshots in the aquatone_script_result folder. "
}

#  Checking input 
if [ "$1" == "-h" ]; then
    show_help
    exit 0
fi

#Domain Input
read -p "Enter domain: " domain

# Output folder setup
output_base="aquatone_script_result"
output_dir="$output_base/$domain/recon"
mkdir -p $output_dir

# subdomain collect
echo "[+] Gathering subdomains..."
subfinder -d $domain > $output_dir/subdomains.txt

# Take screenshot
echo "[+] Taking screenshots with Aquatone..."
cat $output_dir/subdomains.txt | aquatone -threads 10 -out $output_dir/aquatone_output

# show report
echo "[+] Aquatone process complete. Open the report:"
firefox $output_dir/aquatone_output/aquatone_report.html

echo "[+] All results saved in $output_base/$domain"
echo "[+] Thanks Admas"
