Feature: Login
  Background:
    * url baseUrl

  Scenario: Validate and login into system

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