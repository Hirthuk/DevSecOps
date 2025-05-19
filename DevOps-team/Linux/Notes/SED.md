# **Complete sed Cheat Sheet**

## **Basic Usage**
```sh
sed [options] 'command' file.txt
```

## **Common Options**
| Option | Description |
|--------|-------------|
| `-n`   | Suppress automatic printing |
| `-i`   | Edit file in-place |
| `-i.bak` | Edit with backup (.bak) |
| `-E`   | Extended regex |
| `-e`   | Multiple commands |
| `-f`   | Read commands from file |

## **Substitution (Search & Replace)**
```sh
sed 's/old/new/' file.txt        # Replace first occurrence per line
sed 's/old/new/g' file.txt       # Replace all occurrences
sed 's/old/new/2' file.txt       # Replace only 2nd occurrence
sed 's/old/new/I' file.txt       # Case-insensitive replace
sed 's|/old|/new|g' file.txt     # Custom delimiter (useful for paths)
```

## **Line Addressing**
```sh
sed '3s/old/new/' file.txt       # Replace only on line 3
sed '1,5s/old/new/' file.txt     # Replace in lines 1-5
sed '/pattern/s/old/new/' file.txt # Replace only in matching lines
sed '$s/old/new/' file.txt       # Replace in last line
```

## **Deletion**
```sh
sed '3d' file.txt                # Delete line 3
sed '1,5d' file.txt              # Delete lines 1-5
sed '/pattern/d' file.txt        # Delete matching lines
sed '/start/,/end/d' file.txt    # Delete range between patterns
sed '/^$/d' file.txt             # Delete empty lines
```

## **Printing**
```sh
sed -n '5p' file.txt             # Print only line 5
sed -n '10,20p' file.txt         # Print lines 10-20
sed -n '/pattern/p' file.txt     # Print matching lines
sed -n '/start/,/end/p' file.txt # Print range between patterns
```

## **Insertion/Appending**
```sh
sed '3i\New Line' file.txt       # Insert before line 3
sed '$a\Appended Line' file.txt  # Append at end of file
sed '/pattern/i\Text' file.txt   # Insert before matching line
sed '/pattern/a\Text' file.txt   # Append after matching line
```

## **Transformations**
```sh
sed 'y/abc/ABC/' file.txt        # Character translation
sed 's/.*/\U&/' file.txt         # Convert line to uppercase
sed 's/.*/\L&/' file.txt         # Convert line to lowercase
```

## **Advanced Features**
```sh
# Multiple commands
sed -e 's/foo/bar/' -e 's/baz/qux/' file.txt

# Use hold buffer
sed -n '/pattern/{h;n;H;x;p}' file.txt

# Numbering lines
sed = file.txt | sed 'N;s/\n/\t/'

# Print line numbers with matches
sed -n '/pattern/{=;p}' file.txt | sed 'N;s/\n/ /'
```

## **Regex Examples**
```sh
sed -E 's/[0-9]+/NUMBER/g' file.txt  # Replace numbers
sed 's/^#.*//' file.txt             # Remove comments
sed 's/\s\+/ /g' file.txt           # Collapse multiple spaces
sed 's/<[^>]*>//g' file.txt         # Remove HTML tags
```

## **In-File Editing**
```sh
sed -i 's/old/new/g' file.txt      # Modify file directly
sed -i.bak 's/old/new/g' file.txt  # Keep backup
```

## **Common Use Cases**
```sh
# Remove DOS line endings
sed 's/\r$//' file.txt > newfile.txt

# Delete trailing whitespace
sed 's/[ \t]*$//' file.txt

# Add text to beginning of file
sed '1i\Header Text' file.txt

# Extract specific lines
sed -n '5,10p' file.txt > extract.txt
```

## **Special Characters**
| Character | Meaning |
|-----------|---------|
| `^`       | Start of line |
| `$`       | End of line |
| `.`       | Any character |
| `*`       | Zero or more |
| `\+`      | One or more |
| `\?`      | Zero or one |
| `\|`      | OR operator |
| `\( \)`   | Grouping |
| `\1`      | Backreference |

This cheat sheet covers the most essential sed commands and techniques. For complex text processing tasks, you can combine sed with other tools like grep and awk for even more powerful transformations.