#!/bin/bash
list() {
    echo "Files in the current directory:"
    ls -a | sort
}

copy() {
    read -p "Enter source directory: " src_dir
    read -p "Enter destination directory: " dest_dir
    [[ ! -d "$src_dir" ]] && echo "Source does not exist." && return

    mkdir -p "$dest_dir"
    cp -r "$src_dir"/* "$dest_dir" && echo "Great Success!!" || echo "Copy failed."
}

move() {
    read -p "Enter source directory: " src_dir
    read -p "Enter destination directory: " dest_dir
    [[ ! -d "$src_dir" ]] && echo "Source does not exist." && return

    mkdir -p "$dest_dir"
    for item in "$src_dir"/*; do
        [[ -e "$item" ]] || continue
        dest_item="$dest_dir/$(basename "$item")"
        if [[ -e "$dest_item" ]]; then
            read -p "$dest_item exists. Overwrite? (y/n): " choice
            [[ "$choice" != "y" ]] && continue
        fi
        mv "$item" "$dest_dir"
    done
    echo "Great Success!!"
}


delete() {
    read -p "Enter directory to delete files from: " dir
    [[ ! -d "$dir" ]] && echo "Directory does not exist." && return

    for item in "$dir"/*; do
        [[ -f "$item" && "$item" != .* ]] || continue
        read -p "Delete $(basename "$item")? (y/n): " choice
        [[ "$choice" == "y" ]] && rm "$item" && echo "$item deleted."
    done
}

while true; do
    echo -e "\n1. List files\n2. Copy files\n3. Move files\n4. Delete files\n5. Exit"
    read -p "Choose an option: " choice
    case $choice in
        1) list ;;
        2) copy ;;
        3) move ;;
        4) delete ;;
        5) echo "Exiting." ; exit ;;
        *) echo "Invalid option." ;;
    esac
done
