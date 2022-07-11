#!/usr/bin/bash
filename="./$1"
if [ -f "$filename" ]; then
    i=1
    while read -r url;do
        mkdir $url
        echo "RECON STARTED on [ ${url}]"
        gau.exe $url|httprobe.exe|tee $url/gau200.txt
		waybackurls.exe $url|httprobe.exe|tee $url/wayback200.txt
		echo $url|sed -e s/'http[s]\?:\/\/'//|nmap|awk '/open/{print $1 $2 " " $3}'|tee $url/openports.txt
        i=$((i+1))
        echo "SCANNING IS FINISHED on [ ${url} ]"|notify
    done < "$filename"
else
    echo "File is not Exist ${filename}"
    exit 
fi
