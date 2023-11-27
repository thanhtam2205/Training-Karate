@GetAllJob
Feature: Put API demo
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
    And form field username = 'Admin'
    And form field password = 'admin123'
    And form field _token = token
    When method post
    Then status 302
    * def cookie = responseCookies
    * print cookie


    Given path 'api/v2/admin/job-titles'
    And params { "limit": 50, "offset": 0, "sortField": "jt.jobTitleName", "sortOrder": "ASC"}
    And headers { Cookie: '#(cookie)'}
    When method get
    Then status 200
    And print response
