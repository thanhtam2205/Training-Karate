Feature: Post API demo
  Background:
    * url 'https://reqres.in/api/'
    * header Accept = 'application/json'

  @Smoke
  Scenario: Post demo 1
    Given path 'users'
    And request { "name": "Raghav", "job": "leader"}
    When method post
    Then status 201

  Scenario: Post with response assertion
    Given path 'users'
    And request { "name": "Raghav", "job": "leader"}
    When method post
    Then status 201
    And match response == {"name": "Raghav", "job": "leader","id": "#string","createdAt": "#ignore"}