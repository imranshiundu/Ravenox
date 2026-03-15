import os
import re

def fix_content(content):
    # 1. Fix docs().ai corruption
    content = content.replace('docs().ai', 'docs.ravenox.ai')
    
    # 2. Fix unquoted/broken ravenox strings (exhaustive)
    # [.ravenox -> ["ravenox
    content = re.sub(r'\[\.?ravenox\b\s+', '["ravenox ', content)
    # (.ravenox -> ("ravenox
    content = re.sub(r'\(\.?ravenox\b\s+', '("ravenox ', content)
    # "ravenox channels" (no leading quote)
    content = re.sub(r'(?<!["`/])\bravenox\s+(channels|memory|message|agent|models|gateway|status|info|help|login|logout|doctor)', r'"ravenox \1', content)
    
    # 3. Fix infra sashes
    content = content.replace('infra()-root.js', 'infra/root.js')
    content = content.replace('ravenox()-root.js', 'infra/root.js')
    
    # 4. Fix Symbol.for
    content = re.sub(r'Symbol\.for\(([^"])', r'Symbol.for("\1', content)
    # Ensure ravenox inside Symbol.for is quoted
    content = content.replace('Symbol.for(.ravenox', 'Symbol.for("ravenox')
    
    # 5. Fix common keywords
    content = content.replace('ravenox requires Node', '"ravenox requires Node')
    content = content.replace('re-run().', 're-run ravenox.')
    content = content.replace('re-run().ravenox', 're-run ravenox')
    
    # 6. Fix resolveUserPath
    content = re.sub(r'resolveUserPath\.ravenoxStateDir', r'resolveUserPath(ravenoxStateDir)', content)
    
    # 7. Double nullish cleanup
    content = re.sub(r'\?\?\s*\?\?\s*', '?? ', content)
    
    # 8. Import meta normalization
    content = content.replace('import meta', 'import.meta')
    
    # 9. Normalize spread operators
    content = re.sub(r'\.{4,}', '...', content)

    # 10. Fix Regex in cli-name.ts
    content = content.replace(')?.ravenox)\\b', ')?ravenox)\\b')
    
    return content

def main():
    for root, dirs, files in os.walk('src'):
        for file in files:
            if file.endswith('.ts') or file.endswith('.js'):
                path = os.path.join(root, file)
                with open(path, 'r') as f:
                    old = f.read()
                new = fix_content(old)
                if old != new:
                    with open(path, 'w') as f:
                        f.write(new)

if __name__ == '__main__':
    main()
