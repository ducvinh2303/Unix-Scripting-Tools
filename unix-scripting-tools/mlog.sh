#DucVinhVu - 641029
#!/bin/bash

# Check for existence of user.deny file
if [ ! -f user.deny ]; then
    echo "The file user.deny does not exist!"
    exit 1
fi

# Function to check if user has logged in multiple times
check_multiple_logins() {
    # Iterate through each username in the user.deny file
    while read -r username; do
        login_count=$(who | grep -w "$username" | wc -l)
        if [ "$login_count" -gt 1 ]; 
        then
            full_name=$(getent passwd "$username" | cut -d ":" -f 5 | cut -d "," -f 1)
            echo "The user $full_name (on the denial list) has logged in more than once!"
        else
            echo "No user on the user.deny list has multiple logins"
        fi
    done < user.deny
}

# Infinite loop to check every 3 seconds
while true; do
    if [ -s user.deny ]; then
        # Check for multiple user logins
        check_multiple_logins
    else
        echo "No user on the user.deny list has multiple logins"
    fi
    
    # Wait 3 seconds before checking again
    sleep 3
done
