
function() {
  return {
    getToken: function(response){
//    const $ = cheerio.load(response.text());
//    const token = $('auth-login')[0].attribs[":token"].replaceAll("\"", "");
      let index1 = response.indexOf(":token");
      let index2 = response.indexOf(":login-logo-src");
      const token1 = response.slice(index1+14, index2);
      let index3 = token1.indexOf("&quot");
      const token2 = token1.slice(0,index3);
    return token2;
    }
  }
}
