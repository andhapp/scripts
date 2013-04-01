var fs, csvHandler, emailMatcher, websiteHeader, unprocessedFilePath, processedFilePath;

fs = require('fs');
csvHandler = require('csv');

emailMatcher = /(\w+)(@)(.*)/;
websiteHeader = "Website";
unprocessedFilePath = __dirname + '/unprocessed.csv';
processedFilePath = __dirname + '/processed.csv';

csvHandler()
.from.stream(fs.createReadStream(unprocessedFilePath))
.to.path(processedFilePath)
.transform(extractWebsiteFromEmail)
.on('end', function(count) {
  console.log('Records processed: ' + count);
})
.on('error', function(error) {
  console.log(error.message);
});

function extractWebsiteFromEmail(row) {
  var emailAddress, websiteAddress, columns;

  columns = row.length;
  emailAddress = row[columns - 1];
  emailAddressArr = emailMatcher.exec(emailAddress);

  if(emailAddressArr !== null) {
    row[columns] = "www." + emailAddressArr[3];
  } else {
    row[columns] = websiteHeader;
  }

  return row;
}
