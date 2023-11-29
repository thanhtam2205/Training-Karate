
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
    getExpectedResponseForPostJob(request){
       let data = {
            "id":'#number',
            "title": request.title,
            "description": request.description,
            "note": request.note,
            "jobSpecification": {
                "id": '#number',
                "filename":"",
                "fileType": "",
                "fileSize": "",
                }
       };

       if (request.description == "" || request.description == null ) data.description = null;
       if (request.note == "" || request.note == null ) data.note = null;
       if (request.note == "" || request.note == null ) data.note = null;
       if (request.specification == "" || request.specification == null )
          {
             data.jobSpecification.id = null;
             data.jobSpecification.filename = null;
             data.jobSpecification.fileType = null;
             data.jobSpecification.fileSize = null;
          }
          else {
             data.jobSpecification.filename = request.specification.name;
             data.jobSpecification.fileType = request.specification.type;
             data.jobSpecification.fileSize = request.specification.size;
          }
       return {"data": data, "meta": [],"rels": []};
    }
  }
}
