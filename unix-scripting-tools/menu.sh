#DucVinhVu - 641029
#!/bin/bash

# Check for existence of file records
if [ ! -f records ]; then
    echo "File records do not exist!"
    exit 1
fi

# Function to display menu
display_menu() {
    echo "Dominion Consulting Employees Info Main Menu"
    echo "============================================"
    echo "1 - Print All Current Records"
    echo "2 - Search for Specific Record(s)"
    echo "3 - Add New Records"
    echo "4 - Delete Records"
    echo "Q - Quit"
}

# Show full profile
print_records() {
    cat records

    echo -e "\n"
    read -p "Press Enter to continue... ";
    echo -e "\n"
}

# Search record function
search_records() {
    read -p "Enter keyword: " keyword
    if [ -z "$keyword" ]; then
        echo "Keyword not entered"
        return
    fi

    # Search for keywords in records file, case insensitive
    result=$(grep -i "$keyword" records)

    if [ -z "$result" ]; then
        echo "$keyword not found"
    else
        echo "$result"
    fi

    echo -e "\n"
    read -p "Press Enter to continue... ";
    echo -e "\n"
}

# Function to add new profile
add_record() {
    while true; do
        echo "Add New Employee Record"
        
        # Enter phone number and check validity
        while true; do
            read -p "Phone Number (xxxxxxxx): " phone
            if [[ -z "$phone" ]]; then
                echo "Phone number not entered"
                continue
            fi

            if [[ ! "$phone" =~ ^[1-9][0-9]{7}$ ]]; then
                echo "Invalid phone number"
                continue
            fi

            # Check if phone number already exists
            if grep -q "^$phone:" records; then
                echo "Phone number exists"
                continue
            fi
            break
        done
        echo -e "\n"

        # Enter your name and check for validity
        while true; do
            read -p "Family Name: " lastname
            if [[ ! "$lastname" =~ ^[a-zA-Z[:space:]]+$ ]]; then
                echo "Family name can contain only alphabetic characters and spaces"
                continue
            fi
            break
        done
        echo -e "\n"

        # Enter name and check validity
        while true; do
            read -p "Given Name: " firstname
            if [[ ! "$firstname" =~ ^[a-zA-Z[:space:]]+$ ]]; then
                echo "Given name can contain only alphabetic characters and spaces"
                continue
            fi
            break
        done
        echo -e "\n"

        # Enter department number and check validity
        while true; do
            read -p "Department Number: " department
            if [[ ! "$department" =~ ^[0-9]{2}$ ]]; then
                echo "A valid department number contains 2 digits"
                continue
            fi
            break
        done
        echo -e "\n"

        # Enter job title and check validity
        while true; do
            read -p "Job Title: " jobtitle
            if [[ ! "$jobtitle" =~ ^[a-zA-Z[:space:]]+$ ]]; then
                echo "Job title can contain only alphabetic characters and spaces"
                continue
            fi
            break
        done

        echo "Adding new employee record to the records file ..."

        # Add new records to the records file
        echo "$phone:$lastname:$firstname:$department:$jobtitle" >> records
        
        echo "New record saved"
        echo -e "\n"

        # Ask the user if they want to add another profile
        while true; do
            read -p "Add another? (y)es or (n)o: " choice
            case "$choice" in
                [Yy]*) 
                    # User selects "yes", continues to add new profile
                    break
                    ;;
                [Nn]*) 
                    # The user selects "no", exits the loop and ends the function.
                    echo -e "\n"
                    return
                    ;;
            esac
        done
    done
}


# Delete profile function
delete_record() {
    echo "Delete Employee Record"
    echo -e "\n"

    while true; do
            read -p "Enter a phone number: " phone
            if [[ -z "$phone" ]]; then
                echo "Phone number not entered"
                continue
            fi

            if [[ ! "$phone" =~ ^[1-9][0-9]{7}$ ]]; then
                echo "Invalid phone number"
                continue
            fi

            # Check if phone number already exists
            if ! grep -q "^$phone:" records; then
                echo "Phone number not found"
                continue
            fi
            break
        done
    result=$(grep -i "$phone" records)
    echo $result

    # Confirm delete this record
    while true; do
        echo -e "\n"
        read -p "Confirm deletion: (y)es or (n)o: " choice
        case "$choice" in
            [Yy]*) 
                # User selects "yes", continues to add new profile
                echo -e "\n"
                break
                ;;
            [Nn]*) 
                # The user selects "no", exits the loop and ends the function.
                echo -e "\n"
                return
                ;;
        esac
    done

    grep -v "^$phone:" records > temp && mv temp records
    echo "Record deleted."
    echo -e "\n"
}

# Start menu loop
while true; do
    display_menu
    read -p "Your Selection: " choice
    case $choice in
        1) print_records ;;
        2) search_records ;;
        3) add_record ;;
        4) delete_record ;;
        Q|q) exit 0 ;;
        *) echo "Invalid selection"
        echo -e "\n"
        read -p "Press Enter to continue... ";
        echo -e "\n" ;;
    esac
done

