#DucVinhVu - 641029
#!/bin/bash

# Input check: 3 arguments need to be provided (folder1, folder2, folder3)
if [ "$#" -ne 3 ]; then
    echo "The program needs 3 parameters"
    exit 1
fi

folder1=$1
folder2=$2
folder3=$3

# Check for existence of folder1 and folder2
if [ ! -d "$folder1" ]; then
    echo "Folder $folder1 doesn't exists!"
    exit 1
fi

if [ ! -d "$folder2" ]; then
    echo "Folder $folder2 doesn't exists!"
    exit 1
fi

# Check if destination directory folder3 exists
if [ -d "$folder3" ]; then
    echo "Folder $folder3 is exists! Please choose another name."
    exit 1
fi

# Create folder3 directory
mkdir "$folder3"

# Copy all files from folder1 to folder3 and keep the timestamp
echo "These files from $folder1 copied into $folder3:"
cp -p "$folder1"/* "$folder3"
ls "$folder1"

echo -e "\n"

# Copy all data from folder1 folder to folder3 folder
echo "These new file(s) from $folder2 copied into $folder3:"
for file in "$folder2"/*; do
    filename=$(basename "$file")
    if [ ! -f "$folder3/$filename" ]; then
        cp -p "$file" "$folder3"
        echo "$filename"
    fi
done

echo -e "\n"

# The script then copies every file from folder2 to folder3 subject to these conditions: if the file from folder2 is not already present in folder3, or if the folder2 file is newer than the same folder3 file it will overwrite its namesake in folder3
echo "These file(s) from $folder2 copied into $folder3 and overwrite(s) their namesakes in $folder3"
for file in "$folder2"/*; do
    filename=$(basename "$file")
    if [ -f "$folder3/$filename" ] && [ "$file" -nt "$folder3/$filename" ]; then
        cp -p "$file" "$folder3"
        echo "$filename"
    fi
done

