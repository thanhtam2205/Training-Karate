@GetAllJob
Feature: Put API demo
  Background:
    * url 'https://opensource-demo.orangehrmlive.com/web/index.php'

  Scenario: Get all job

    Given path 'auth/login'
    And headers { Accept: "application/json", Connection: 'Keep-Alive', Accept-Encoding: "gzip, deflate, br", User-Agent:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}
    When method get
    Then status 200
    And print response
    * def parseXml = read('utils/jsUtils.js')
    * def token = parseXml().getToken(response)
    * print token

    Given path 'auth/validate'
    And request {username : 'Admin', password: 'admin123', _token : '#(token)'}
    And headers { Accept: "application/json", Connection: 'Keep-Alive', Accept-Encoding: "gzip, deflate, br", User-Agent:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}
    When method post
    Then status 200
    * def cookie = responseCookies.orangehrm.value
    * print cookie


    Given path 'api/v2/admin/job-titles'
    And params { "limit": 50, "offset": 0, "sortField": "jt.jobTitleName", "sortOrder": "ASC"}
    And headers { Accept: "application/json", Connection: 'Keep-Alive', Accept-Encoding: "gzip, deflate, br", User-Agent:"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}
    When method get
    Then status 200
    And print response
