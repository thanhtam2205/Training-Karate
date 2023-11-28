@PostJob
@tc
Feature: Post job API demo
  Background:
    * url baseUrl
    * def authen = callonce read('../config/authentication/login.feature')
    * def jsUtils = read('../utils/jsUtils.js')
    * def cookie = 'orangehrm='+authen.cookie.orangehrm.value
    * def data = read('testData/TC_01.json')
    And data.title = data.title + jsUtils().getCurrentDate()


    Scenario: Add job successfully with all valid field

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request data
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    * match response.data.id == '#number'
    * match response.data.title == data.title
    * match response.data.description == data.description
    * match response.data.note == data.note
    * match response.data.jobSpecification.id == '#number'
    * match response.data.jobSpecification.filename == data.specification.name
    * match response.data.jobSpecification.fileType == data.specification.type
    * match response.data.jobSpecification.fileSize == data.specification.size
    * match response.meta == '#[0]'
    * match response.rels == '#[0]'

    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200