@PostJob
Feature: Post job API demo
  Background:
    * url 'https://opensource-demo.orangehrmlive.com/web/index.php'

  Scenario: Add job successfully wit blank title

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

    #get all job
    Given path 'api/v2/admin/job-titles'
    And params { "offset": 0, "sortField": "jt.jobTitleName", "sortOrder": "ASC"}
    And headers { Cookie: '#(cookie)'}
    When method get
    Then status 200

    * def idTitle = jsUtils().getIDOfBlankTitle(response)
    # delete blank title
    Given path 'api/v2/admin/job-titles'
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(idTitle)']}
    When method delete
    Then status 200

    * def data = read('testData/TC_02.json')

    Given path 'api/v2/admin/job-titles'
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


    Given path 'api/v2/admin/job-titles'
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200