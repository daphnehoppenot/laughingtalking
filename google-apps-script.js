// Google Apps Script for Email Collection
// This script receives POST requests and saves emails to a Google Sheet

function doPost(e) {
  try {
    // Get the active spreadsheet
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();

    // Parse the incoming data
    const data = JSON.parse(e.postData.contents);
    const email = data.email;
    const timestamp = new Date();

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return ContentService.createTextOutput(JSON.stringify({
        success: false,
        message: 'Invalid email format'
      })).setMimeType(ContentService.MimeType.JSON);
    }

    // Check if email already exists
    const existingEmails = sheet.getRange(2, 1, sheet.getLastRow() - 1, 1).getValues();
    const emailExists = existingEmails.some(row => row[0] === email);

    if (emailExists) {
      return ContentService.createTextOutput(JSON.stringify({
        success: true,
        message: 'Email already registered',
        duplicate: true
      })).setMimeType(ContentService.MimeType.JSON);
    }

    // Add new row with email and timestamp
    sheet.appendRow([email, timestamp]);

    // Return success response
    return ContentService.createTextOutput(JSON.stringify({
      success: true,
      message: 'Email saved successfully'
    })).setMimeType(ContentService.MimeType.JSON);

  } catch (error) {
    // Return error response
    return ContentService.createTextOutput(JSON.stringify({
      success: false,
      message: 'Error saving email: ' + error.message
    })).setMimeType(ContentService.MimeType.JSON);
  }
}

// Test function (optional - for testing in Apps Script editor)
function doGet(e) {
  return ContentService.createTextOutput(JSON.stringify({
    status: 'Laughing Talking Email Collection API is running',
    message: 'Use POST requests to submit emails'
  })).setMimeType(ContentService.MimeType.JSON);
}
