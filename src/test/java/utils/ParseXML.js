var cheerio = require('cheerio');

function getToken(response) {
const $ = cheerio.load(response.text());
const token = $('auth-login')[0].attribs[":token"].replaceAll("\"", "")
return token;
}