#!/usr/bin/bash

opt="$1"
path="$2"

org=$(realpath "$path" 2>/dev/null)

if [ "$opt" = "init" ]; then
    if [ -d "$org" ]; then
        find "$org" -type f -exec sha256sum {} + > hashes.txt
    else
        sha256sum "$org" > hashes.txt
    fi
    echo -e "\nHashes initialized successfully."

elif [ "$opt" = "check" ] || [ "$opt" = "-check" ]; then
    oldhash=$(grep "$org" hashes.txt | awk '{print $1}')
    newhash=$(sha256sum "$org" | awk '{print $1}')

    if [ -z "$oldhash" ]; then
        echo -e "\nFile is not tracked in hashes.txt."
    elif [ "$oldhash" = "$newhash" ]; then
        echo -e "\nThe log file hasn't changed."
    else
        echo -e "\nThe file has been modified!"
    fi

elif [ "$opt" = "update" ]; then
    grep -v "$org" hashes.txt > tmp.txt 2>/dev/null
    mv tmp.txt hashes.txt 2>/dev/null
    sha256sum "$org" >> hashes.txt
    echo -e "\nHash updated successfully."
fi
