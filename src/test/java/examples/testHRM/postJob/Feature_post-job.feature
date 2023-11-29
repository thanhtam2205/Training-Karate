@PostJob
@tc
@testOutline
Feature: Post job API demo
  Background:
    * url baseUrl
    * def authen = callonce read('../config/authentication/login.feature')
    * def jsUtils = read('../utils/jsUtils.js')
    * def cookie = 'orangehrm='+authen.cookie.orangehrm.value
#    * def data = read('testData/TC_01.json')
#    And data.title = data.title + jsUtils().getCurrentDate()

  Scenario Outline:

    * def testData = read('<data>')
    And testData.title = testData.title + jsUtils().getCurrentDate()

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    * match response == jsUtils().getExpectedResponseForPostJob(testData)

    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200
#    * match response.data.id == '#number'
#    * match response.data.title == '<title>'
#    * match response.data.description == '<description>'
#    * match response.data.note == '<note>'
#    * match response.data.jobSpecification.id == '#number'
#    * match response.data.jobSpecification.filename == data.specification.name
#    * match response.data.jobSpecification.fileType == data.specification.type
#    * match response.data.jobSpecification.fileSize == data.specification.size
#    * match response.meta == '#[0]'
#    * match response.rels == '#[0]'

    Examples:
      |data               |
      |testData/TC_01.json|
      |testData/TC_03.json|
      |testData/TC_04.json|
      |testData/TC_05.json|
      |testData/TC_06.json|
      |testData/TC_07.json|
      |testData/TC_08.json|



#    Examples:
#      |title          | description   |specification  |note       |expected          |
#      |QA automation  | "none"   |{"base64":"IlRhbSIsIiIsIkxlIiwiMzY5NiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiI=","name": "text.txt","type": "text/plain","size": 74}  |note       |expected          |
#      |title  | description   |specification  |note       |expected          |
#      |title  | description   |specification  |note       |expected          |