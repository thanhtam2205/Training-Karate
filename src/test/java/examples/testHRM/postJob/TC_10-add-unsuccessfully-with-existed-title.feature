@PostJob
Feature: Post job API demo
  Background:
    * url 'https://opensource-demo.orangehrmlive.com/web/index.php'

  Scenario: Add job successfully wit existedtitle

    Given path 'auth/login'
    When method get
    Then status 200
    And print response
    * def jsUtils = read('../utils/jsUtils.js')
    * def token = jsUtils().getToken(response)
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

    * def data = read('testData/TC_03.json')
    And data.title = data.title + jsUtils().getCurrentDate()

    Given path 'api/v2/admin/job-titles'
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request data
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    Given path 'api/v2/admin/job-titles'
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request data
    When method post
    Then status 422

    * match response.error.status == '422'
    * match response.error.message == 'Invalid Parameter'
    * match response.error.data.invalidParamKeys[0] == 'title'


    Given path 'api/v2/admin/job-titles'
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200