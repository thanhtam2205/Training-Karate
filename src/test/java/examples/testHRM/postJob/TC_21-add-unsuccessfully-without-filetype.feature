@PostJob
Feature: Post job API demo
  Background:
    * url 'https://opensource-demo.orangehrmlive.com/web/index.php'

  Scenario: Add job unsuccessfully without filetype

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

    * def data = read('testData/TC_21.json')

    Given path 'api/v2/admin/job-titles'
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request data
    When method post
    Then status 422

    * match response.error.status == '422'
    * match response.error.message == 'Invalid Parameter'
    * match response.error.data.invalidParamKeys[0] == 'specification'
