import os
import re

def sanitize_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    # Pattern 1: .ravenox" -> "ravenox"
    content = re.sub(r'([ (\[=,])\.ravenox"', r'\1"ravenox"', content)
    
    # Pattern 2: .ravenox. -> "ravenox.
    content = re.sub(r'([ (\[=,])\.ravenox\.', r'\1"ravenox.', content)
    
    # Pattern 3: .ravenox- -> "ravenox-
    content = re.sub(r'([ (\[=,])\.ravenox-', r'\1"ravenox-', content)

    # Pattern 4: Fix the regex in ports.ts or similar
    # if (.ravenox|... -> if (/\.ravenox|...
    content = re.sub(r'if \(\.ravenox\|', r'if (/\.ravenox|', content)
    # index\.js\/.test -> index\.js\/.test (regex closing)
    # Actually, pattern 4 needs to find the end of the regex
    content = re.sub(r'if \((/\.ravenox[^)]+)\.test\(', r'if (\1/.test(', content)

    # Pattern 5: Fix specific broken symbols
    content = re.sub(r'Symbol\.for\(\.ravenox', r'Symbol.for("ravenox', content)

    # Pattern 6: Fix mismatched quotes like ["ravenox...']
    content = re.sub(r'\["ravenox([^"]+)\'\]', r'["ravenox\1"]', content)

    # Pattern 7: Fix accidentally doubled quotes or empty quotes from previous sed
    content = content.replace('  ""', ' ?? ""') # restore nullish coalescing if it looks like we broke it
    
    with open(filepath, 'w') as f:
        f.write(content)

def main():
    src_dir = 'src'
    for root, dirs, files in os.walk(src_dir):
        for file in files:
            if file.endswith('.ts') or file.endswith('.js'):
                sanitize_file(os.path.join(root, file))

if __name__ == '__main__':
    main()
