#!/usr/bin/env bash
find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs -r sed -i 's/"ravenox/"ravenox/g'
find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs -r sed -i 's/"@ravenox/"@ravenox/g'
find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs -r sed -i 's/\ravenox-gateway/ravenox-gateway/g'
find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs -r sed -i 's/\Ravenox requires/Ravenox requires/g'
find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs -r sed -i 's/\[\.ravenox/["ravenox/g'
