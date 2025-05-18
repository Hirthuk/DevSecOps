# Log File Analysis with AWK, Grep & Sed

<!-- To Download Single file from GitHub repository to local curl -O https://raw.githubusercontent.com/logpai/loghub/20168f0fc076be8a75d22c01896076090d4a3c6e/Linux/Linux_2k.log

Copy the permalink of the file replace github.com/blob with raw.githubusercontent.com. curl 0 is to downloading with the same file name -->

## Use grep to find all occurrences of the word "error"
` grep [options] "search_pattern" [file(s)] -- Basic syntax

grep "error" Linux_2k.log `


1. **`grep "error" file.txt`** → Search for the word *"error"* in `file.txt`.  
2. **`grep -i "warning" file.txt`** → Case-insensitive search for *"warning"*.  
3. **`grep "failed" file1.txt file2.txt`** → Search *"failed"* in multiple files.  
4. **`grep -c "success" file.txt`** → Count how many lines contain *"success"*.  
5. **`grep -n "crash" file.txt`** → Show matching lines *with line numbers*.  
6. **`grep -r "connection" /var/log/`** → Search *"connection"* recursively in a directory.  
7. **`grep -v "active" file.txt`** → Show lines that *do NOT* contain *"active"*.  
8. **`grep -w "port" file.txt`** → Match only the *whole word* *"port"* (not *"export"*).  
9. **`grep "^2023" file.txt`** → Find lines *starting with* *"2023"* (regex).  
10. **`grep "error.*file" file.txt`** → Match *"error" followed by "file"* (regex).  
11. **`cat file.txt | grep "important"`** → Pipe output into `grep` to search *"important"*.  
12. **`ps aux | grep "nginx"`** → Search for *"nginx"* in running processes.  

**Key Options**:  
- `-i` → Ignore uppercase/lowercase.  
- `-c` → Count matches.  
- `-n` → Show line numbers.  
- `-r` → Search subdirectories.  
- `-v` → Invert match (exclude).  
- `-w` → Match whole words only.  

## Use awk to extract timestamps and log levels.
Cat command will fetch all the content of the file. From that | pipings after this awk command taking the ourput of awk command and printing values of the file in the 3rd column
 basic -> awk '{command}' input(filename) -> awk '{print}' file.txt
` cat Linux_2k.log | awk '{print $1 $2 $3 $6}'`

Here’s a concise **one-line-per-command** guide to using `awk` for text processing in Linux:  

---

### **Basic Syntax**  
1. **`awk '{print $1}' file.txt`** → Print the **first column** of each line.  
2. **`awk -F':' '{print $1}' /etc/passwd`** → Use `:` as delimiter (e.g., for `/etc/passwd`).  

---

### **Filtering & Patterns**  
3. **`awk '/error/ {print}' file.log`** → Print lines containing *"error"*.  
4. **`awk '$3 > 100 {print $1, $3}' data.txt`** → Print cols 1 & 3 if col 3 > 100.  
5. **`awk 'NR==2 {print}' file.txt`** → Print only the **2nd line**.  
6. **`awk 'NR>=5 && NR<=10' file.txt`** → Print lines **5 to 10**.  

---

### **Math & Calculations**  
7. **`awk '{sum += $1} END {print sum}' nums.txt`** → Sum values in column 1.  
8. **`awk '{avg = total/NR} END {print avg}' data.txt`** → Calculate average.  

---

### **Built-in Variables**  
9. **`awk '{print NR, $0}' file.txt`** → Add **line numbers** to output.  
10. **`awk '{print NF, $0}' file.txt`** → Show **number of fields** per line.  

---

### **Conditional Logic**  
11. **`awk '{if ($1 == "foo") print $2; else print "NA"}' file.txt`** → If-else logic.  
12. **`awk '$1 ~ /^[0-9]+$/ {print "Number"}' file.txt`** → Regex match (numbers only).  

---

### **Field Manipulation**  
13. **`awk '{$2="new_val"; print $0}' file.txt`** → Replace 2nd column with *"new_val"*.  
14. **`awk '{print $2, $1}' file.txt`** → Swap columns 1 and 2.  

---

### **Multi-Command Blocks**  
15. **`awk 'BEGIN {FS=":"; OFS="-"}; {print $1,$3}' /etc/passwd`** → Set input/output delimiters
awk '{FS=":"; OFS="-"}; {print $1,$3}' /etc/passwd