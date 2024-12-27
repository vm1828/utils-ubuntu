#!/bin/bash

echo "" && echo "===================================================== APPS" && echo ""

./scripts/install.sh

echo "" && echo "===================================================== LANGUAGES" && echo ""

./scripts/languages.sh

echo "" && echo "===================================================== SHORTCUTS" && echo ""

./scripts/shortcuts.sh

echo "" && echo "===================================================== CRONJOBS" && echo ""

./scripts/cronjobs.sh

echo ""
