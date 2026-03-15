#!/bin/bash

# A precise, one-shot script to fix the most common rebranding shrapnel.
# Run this from the repository root.

echo "Running surgical syntax cleanup..."

# 1. Fix missing opening quotes for ravenox strings
# Examples: [.ravenox command", -> ["ravenox command",
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\[\.ravenox /\["ravenox /g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/(\.ravenox /("ravenox /g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/ \.ravenox:/ "ravenox:/g' {} +

# 2. Fix the "."ravenox" corruption
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\."ravenox/"\.ravenox/g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/"\."ravenox/"\.ravenox/g' {} +

# 3. Fix broken infra path calls
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/infra()-root/infra\/root/g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/ravenox()-root/infra\/root/g' {} +

# 4. Fix broken function calls
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/resolveUserPath\.ravenoxStateDir/resolveUserPath(ravenoxStateDir)/g' {} +

# 5. Fix Regex corruption
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/ravenox)\\b/ravenox\\b/g' {} +

# 6. Fix help text unquoted start
# Examples: [ravenox agent", -> ["ravenox agent",
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\[ravenox /\["ravenox /g' {} +

# 7. Normalize spread operators
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\.\.\.\.\.\./\.\.\./g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\.\.\.\.\./\.\.\./g' {} +
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/\.\.\.\./\.\.\./g' {} +

# 8. Fix Symbol.for
find src -type f \( -name "*.ts" -o -name "*.js" \) -exec sed -i 's/Symbol\.for(\.ravenox/Symbol\.for("ravenox/g' {} +

echo "Cleanup complete."
