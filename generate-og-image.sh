#!/bin/bash

# Script to generate OG image from HTML
# This requires Chrome/Chromium to be installed

echo "Generating OG image..."

# Check if Chrome is available
if command -v google-chrome &> /dev/null; then
    CHROME="google-chrome"
elif command -v chromium &> /dev/null; then
    CHROME="chromium"
elif [ -f "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
    CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
    echo "Error: Chrome not found. Please install Chrome or use the manual method."
    echo ""
    echo "Manual method:"
    echo "1. Open og-image.html in your browser"
    echo "2. Press Cmd+Shift+P (Chrome DevTools Command Menu)"
    echo "3. Type 'screenshot' and select 'Capture node screenshot'"
    echo "4. Click on the .og-container element"
    echo "5. Save as og-image.png"
    exit 1
fi

# Check if current directory has og-image.html
if [ ! -f "og-image.html" ]; then
    echo "Error: og-image.html not found in current directory"
    exit 1
fi

# Get the absolute path
FILEPATH="$(pwd)/og-image.html"

# Use Chrome headless to take screenshot
"$CHROME" --headless --disable-gpu --screenshot="og-image.png" \
    --window-size=1200,630 \
    --default-background-color=0 \
    "$FILEPATH"

if [ -f "og-image.png" ]; then
    echo "✓ OG image generated successfully: og-image.png"
    echo "  Dimensions: 1200x630px (optimized for social media)"
else
    echo "✗ Failed to generate image. Please use manual method:"
    echo ""
    echo "Manual method:"
    echo "1. Open og-image.html in Chrome"
    echo "2. Open DevTools (Cmd+Option+I on Mac, F12 on Windows)"
    echo "3. Click the device toolbar icon (phone/tablet icon) or press Cmd+Shift+M"
    echo "4. Set dimensions to 1200 x 630"
    echo "5. Right-click on the page and select 'Capture screenshot'"
    echo "6. Save as og-image.png"
fi
