# Deploy Laughing Talking to GitHub Pages

## Steps to Deploy Using Sourcetree

### 1. Create Repository in GitHub (if not already done)
- Go to github.com and sign in
- Click the "+" icon → "New repository"
- Name it exactly: `laughingtalking` (or any name you prefer)
- Make it Public
- Do NOT initialize with README
- Click "Create repository"

### 2. Add Files Using Sourcetree

1. Open Sourcetree
2. Click "New..." → "Create Local Repository"
   - Destination Path: `/Users/daphnehoppenot/laughingtalking`
   - Name: `laughingtalking`
   - Click "Create"

3. Stage your files:
   - You should see `index.html` and `og-image.png` in the "Unstaged files" section
   - Click the checkbox next to both files to stage them

4. Commit:
   - In the bottom text box, type: "Initial commit - landing page"
   - Click "Commit"

5. Add remote (connect to GitHub):
   - Click "Settings" (gear icon) or Repository → Repository Settings
   - Click "Remotes" tab
   - Click "Add"
   - Remote name: `origin`
   - URL: `https://github.com/daphnehoppenot/laughingtalking.git`
     (Replace `daphnehoppenot` with your GitHub username)
   - Click "OK"

6. Push to GitHub:
   - Click "Push" button in the toolbar
   - Check the box next to "main" (or "master")
   - Click "Push"

### 3. Enable GitHub Pages

1. Go to your repository on GitHub: `https://github.com/daphnehoppenot/laughingtalking`
2. Click "Settings" tab
3. Click "Pages" in the left sidebar
4. Under "Source":
   - Select branch: `main` (or `master`)
   - Select folder: `/ (root)`
   - Click "Save"
5. Under "Custom domain":
   - Enter: `laughingtalking.com`
   - Click "Save"

### 4. Configure GoDaddy DNS

1. Log into GoDaddy
2. Go to your domain settings for `laughingtalking.com`
3. Find DNS Management
4. Delete any existing A records pointing to parking pages
5. Add these A records:
   - Type: A, Name: @, Value: `185.199.108.153`, TTL: 600 seconds
   - Type: A, Name: @, Value: `185.199.109.153`, TTL: 600 seconds
   - Type: A, Name: @, Value: `185.199.110.153`, TTL: 600 seconds
   - Type: A, Name: @, Value: `185.199.111.153`, TTL: 600 seconds
6. Add CNAME record:
   - Type: CNAME, Name: www, Value: `daphnehoppenot.github.io`, TTL: 600 seconds
     (Replace `daphnehoppenot` with your GitHub username)

### 5. Wait for Propagation

- DNS changes can take 5-60 minutes to propagate
- GitHub Pages deployment takes 1-5 minutes
- Check status in GitHub Settings → Pages

### Troubleshooting

**If you see 404:**
- Make sure `index.html` is in the root of your repository
- Check that GitHub Pages is enabled with the correct branch

**If domain shows GitHub 404:**
- Wait longer for DNS propagation
- Verify DNS records in GoDaddy match the values above
- Make sure custom domain is set in GitHub Pages settings

**If you get certificate errors:**
- GitHub Pages may still be generating SSL certificate
- Wait 10-20 minutes and try again
