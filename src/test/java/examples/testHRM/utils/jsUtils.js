
function() {
  return {
    getToken: function(response){
      let index1 = response.indexOf(":token");
      let index2 = response.indexOf(":login-logo-src");
      const token1 = response.slice(index1+14, index2);
      let index3 = token1.indexOf("&quot");
      const token2 = token1.slice(0,index3);
    return token2;
    },
    getCurrentDate: function(){
      java.lang.System.currentTimeMillis();
      return java.lang.System.currentTimeMillis();

    },
    getIDOfBlankTitle: function(response){
      for(let i = 0; i < response.data.length; i++)
      if (response.data[i].title == "") return response.data[i].id;
      return -1;
    },
    getExpectedResponseForGetAllJob(param,response){
       let job = {
            "id":'#number',
            "title": '#notnull',
            "description": '#present',
            "note": '#present',
            "jobSpecification": {
                "id": '#present',
                "filename":'#present',
                "fileType": '#present',
                "fileSize": '#present',
                }
       };
       let data = [];
       for (let i = 0; i <= response.data.length-1; i++) {
          data.push(job);
       }

       let offset = ("offset" in param) ? param.offset : 0;

       if (data.length + offset > response.data.length)
       return {"data": data, "meta": {"total": '#number'},"rels": []};
       else return {"data": data, "meta": {"total": data.length + offset },"rels": []};

       }
  }
}
