@PostAllJob
Feature: Post job API demo
  Background:
    * url 'https://opensource-demo.orangehrmlive.com/web/index.php'

  Scenario: Get all job

    Given path 'auth/login'
    When method get
    Then status 200
    And print response
    * def parseXml = read('utils/jsUtils.js')
    * def token = parseXml().getToken(response)
    * print token

    Given path 'auth/validate'
    * configure followRedirects = false
    And headers {Content-Type : 'application/x-www-form-urlencoded'}
    #And request {"username" : 'Admin', "password": 'admin123', "_token" : '#(token)'}
    And form field username = 'Admin'
    And form field password = 'admin123'
    And form field _token = token
    When method post
    Then status 302
    * def cookie = responseCookies
    * print cookie

    * def data =
    """
    {
    "title": "QA automation150 ",
    "description": "none",
    "specification": {
        "base64":"IlRhbSIsIiIsIkxlIiwiMzY5NiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiI=",
        "name": "text.txt",
        "type": "text/plain",
        "size": 74
    },
    "note": null
}
    """
    Given path 'api/v2/admin/job-titles'
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request data
    When method post
    Then status 200
    And print response
    And print response.data.id
    * def id = response.data.id

    * def ids =
    """
    {
      "ids" : ['#(id)']
    }
    """

    Given path 'api/v2/admin/job-titles'
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request ids
    When method delete
    Then status 200
    And print response