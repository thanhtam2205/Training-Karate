Feature: Put API demo
  Background:
    * url 'https://reqres.in/api/'
    * header Accept = 'application/json'

  @Smoke
  Scenario: PUT demo
    Given path 'users/2'
    And request { "name": "Raghav", "job": "leader"}
    When method PUT
    Then status 200
    And print response
    And print responseStatus