File & Directory Permissions

Create folder and file

mkdir devops_workspace
touch devops_workspace/project_notes.txt

Set Permission for the file
chmod 650 project_notes.txt

```
Owner | Group | Others
r--   | rwx   | ---
```
- `r` = read (4)
- `w` = write (2)
- `x` = execute (1)

### **2. Set Exact Permissions (Your Requirement)**
```bash
chmod 740 filename  # Owner: rwx, Group: r--, Others: ---
```
**Breakdown:**
- Owner: `7` (4+2+1 = read + write + execute)
- Group: `4` (read only)
- Others: `0` (no permissions)

### **3. Step-by-Step Implementation**
1. **Check current permissions**:
   ```bash
   ls -l filename
   ```
   Example output:
   ```
   -rw-r--r-- 1 owner group 0 Jan 1 10:00 filename
   ```

2. **Change permissions**:
   ```bash
   chmod 740 filename
   ```

3. **Verify changes**:
   ```bash
   ls -l filename
  