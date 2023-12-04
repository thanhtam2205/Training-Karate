@GetAllJob
Feature: Get API demo
  Background:
    * url baseUrl
    * def authen = callonce read('../config/authentication/login.feature')
    * def jsUtils = read('../utils/jsUtils.js')
    * def cookie = 'orangehrm='+authen.cookie.orangehrm.value

  Scenario Outline: Get all job successfully
    * def testData = read('<data>')

    Given path jobTitlePath
    And params testData
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    When method get
    Then status 200

    * def expectResult = jsUtils().getExpectedResponseForGetAllJob(testData,response)
    * match response.data == expectResult.data
    * match response.meta.total == expectResult.meta.total
    * match response.rels == expectResult.rels
    Examples:
      |data                |
      |testData/TC_01.json |
      |testData/TC_02.json |
      |testData/TC_03.json |
      |testData/TC_04.json |
      |testData/TC_05.json |
      |testData/TC_06.json |
      |testData/TC_07.json |
      |testData/TC_08.json |
      |testData/TC_09.json |

  Scenario Outline: get job unsuccessfully

    * def testData = read('<data>')

    Given path jobTitlePath
    And params testData
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    When method get
    Then status 422

    * match response.error.status == <expectedStatusCode>
    * match response.error.message == <expectedMessage>
    * match response.error.data.invalidParamKeys[0] == <expectedInvalidParamKeys>


    Examples:
      |data                |expectedStatusCode    |expectedMessage      |expectedInvalidParamKeys  |
      |testData/TC_10.json |"422"                 |"Invalid Parameter"  |'limit'                   |
      |testData/TC_11.json |"422"                 |"Invalid Parameter"  |'limit'                   |
      |testData/TC_12.json |"422"                 |"Invalid Parameter"  |'offset'                  |
      |testData/TC_13.json |"422"                 |"Invalid Parameter"  |'offset'                  |
      |testData/TC_14.json |"422"                 |"Invalid Parameter"  |'sortField'               |
      |testData/TC_15.json |"422"                 |"Invalid Parameter"  |'sortOrder'               |


