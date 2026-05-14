#!/usr/bin/env bash
# deploy.sh — one-shot GitHub Pages deploy for Travel Planner
# Usage: bash deploy.sh <your-github-username>
set -e

USERNAME=${1:-"your-github-username"}
REPO="travel-planner"
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "▶ Initialising git..."
cd "$DIR"
git init -q
git add .
git commit -q -m "🚀 Deploy travel planner"

echo "▶ Creating GitHub repo (public)..."
gh repo create "$REPO" --public --source=. --push --description "Travel planner · HK · Shenzhen · Guangzhou" || true

echo "▶ Enabling GitHub Pages on main branch..."
gh api repos/"$USERNAME"/"$REPO"/pages \
  --method POST \
  -f source='{"branch":"main","path":"/"}' 2>/dev/null || true

echo ""
echo "✅  Done! Your site will be live in ~30 s at:"
echo "    https://$USERNAME.github.io/$REPO"
