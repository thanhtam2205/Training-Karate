Feature:  test api get script
  Background:
    * url 'https://reqres.in/api/'

  @Smoke
  Scenario: get API demo
    Given path 'users/2'
    When method get
    Then status 200
    And print response