# Google Sheet Email Collection Setup

Follow these steps to connect your landing page email form to a Google Sheet.

## Step 1: Create a Google Sheet

1. Go to [Google Sheets](https://sheets.google.com)
2. Click "Blank" to create a new spreadsheet
3. Name it "Laughing Talking Email List" (or whatever you prefer)
4. In cell A1, type: **Email**
5. In cell B1, type: **Timestamp**
6. Format the header row (make it bold, add a background color if you like)

Your sheet should look like this:

```
| Email              | Timestamp           |
|--------------------|---------------------|
|                    |                     |
```

## Step 2: Open Apps Script Editor

1. In your Google Sheet, click **Extensions** → **Apps Script**
2. A new tab will open with the Apps Script editor
3. You'll see a default `function myFunction() {}` - delete all of it
4. Copy the ENTIRE contents of `google-apps-script.js` from your project
5. Paste it into the Apps Script editor
6. Click the **Save** icon (💾) or press Cmd+S
7. Name the project "Email Collector" (or any name you like)

## Step 3: Deploy as Web App

1. In the Apps Script editor, click **Deploy** → **New deployment**
2. Click the gear icon ⚙️ next to "Select type"
3. Choose **Web app**
4. Fill in the settings:
   - **Description**: "Email collection endpoint" (or any description)
   - **Execute as**: Me (your Google account email)
   - **Who has access**: Anyone
5. Click **Deploy**
6. You may need to authorize the script:
   - Click **Authorize access**
   - Choose your Google account
   - Click **Advanced** → **Go to Email Collector (unsafe)**
   - Click **Allow**
7. After deployment, you'll see a **Web app URL** - it will look like:
   ```
   https://script.google.com/macros/s/SOME_LONG_STRING/exec
   ```
8. **COPY THIS URL** - you'll need it in the next step

## Step 4: Update Your Landing Page

1. Open `index.html` in your code editor
2. Find this line (around line 562):
   ```javascript
   const GOOGLE_SCRIPT_URL = 'YOUR_GOOGLE_SCRIPT_URL_HERE';
   ```
3. Replace `'YOUR_GOOGLE_SCRIPT_URL_HERE'` with your actual Web App URL from Step 3:
   ```javascript
   const GOOGLE_SCRIPT_URL = 'https://script.google.com/macros/s/SOME_LONG_STRING/exec';
   ```
4. Save the file

## Step 5: Test It

1. Open `index.html` in your browser (or deploy it and visit your live site)
2. Enter a test email address
3. Click "Notify Me"
4. Go back to your Google Sheet
5. You should see your test email appear with a timestamp!

If it worked, you're all set! 🎉

## Step 6: Deploy Your Updated Site

Since you've updated `index.html`, you need to push it to GitHub:

### Using Sourcetree:

1. Open Sourcetree
2. You'll see `index.html` has changes (modified)
3. Stage the file by clicking the checkbox
4. In the commit message box, type: "Connect email form to Google Sheet"
5. Click **Commit**
6. Click **Push** to send it to GitHub
7. Wait 2-3 minutes for GitHub Pages to rebuild

### Or using Terminal:

```bash
cd /Users/daphnehoppenot/laughingtalking
git add index.html
git commit -m "Connect email form to Google Sheet"
git push
```

## Troubleshooting

### Emails not showing up in the sheet?

1. Check that you copied the correct Web App URL
2. Make sure you selected "Anyone" for "Who has access" in deployment settings
3. Try redeploying the web app (Deploy → Manage deployments → Edit → Deploy)
4. Check the browser console (F12) for any errors

### "Authorization required" error?

1. Go back to Apps Script
2. Click Deploy → Manage deployments
3. Click the edit icon (pencil)
4. Make sure "Execute as" is set to "Me"
5. Make sure "Who has access" is set to "Anyone"
6. Click **Deploy**

### Want to redeploy after making changes to the script?

1. Make your changes in the Apps Script editor
2. Save the script
3. Click **Deploy** → **Manage deployments**
4. Click the edit icon (pencil) next to your active deployment
5. Under "Version", select **New version**
6. Click **Deploy**
7. The URL stays the same, so you don't need to update `index.html`

## Viewing Your Email List

Your Google Sheet will automatically update every time someone signs up. You can:
- Download it as CSV or Excel
- Import it into your email marketing tool (Mailchimp, ConvertKit, etc.)
- Share it with team members
- Set up email notifications when new emails come in (using Apps Script triggers)

## Optional: Get Notified for New Signups

If you want to receive an email every time someone signs up:

1. In your Google Sheet, click **Extensions** → **Apps Script**
2. Add this function to your script:

```javascript
function sendEmailNotification(email) {
  MailApp.sendEmail({
    to: 'your-email@example.com',  // Replace with your email
    subject: '🎉 New Laughing Talking Signup!',
    body: 'New email signup: ' + email
  });
}
```

3. Update the `doPost` function to call this after line 32 (after `sheet.appendRow`):

```javascript
sheet.appendRow([email, timestamp]);
sendEmailNotification(email);  // Add this line
```

4. Save and redeploy (see "Want to redeploy" section above)
