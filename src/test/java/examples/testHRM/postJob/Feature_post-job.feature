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

  Scenario Outline: Add new job successfully

    * def testData = read('<data>')
    And testData.title = testData.title + jsUtils().getCurrentDate()

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    * match response.data.id == <expectedJobId>
    * match response.data.title == <expectedJobTitle>
    * match response.data.description == <expectedDescription>
    * match response.data.note == <expectedNote>
    * match response.data.jobSpecification.id == <expectJobSpecificationId>
    * match response.data.jobSpecification.filename == <expectJobSpecificationName>
    * match response.data.jobSpecification.fileType == <expectJobSpecificationType>
    * match response.data.jobSpecification.fileSize == <expectJobSpecificationSize>
    * match response.meta == <expectedMeta>
    * match response.rels == <expectedRels>

    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200

    Examples:
      |data                | expectedJobId! |expectedJobTitle|expectedDescription  |expectedNote  |expectJobSpecificationId |expectJobSpecificationName  |expectJobSpecificationType  |expectJobSpecificationSize  |expectedMeta|expectedRels|
      |testData/TC_01.json |'#number'      |testData.title  |testData.description |testData.note |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |
      |testData/TC_03.json |'#number'      |testData.title  |'#null'              |testData.note |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |
      |testData/TC_04.json |'#number'      |testData.title  |'#null'              |testData.note |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |
      |testData/TC_05.json |'#number'      |testData.title  |testData.description |testData.note |'#null'                  |'#null'                     |'#null'                     |'#null'                     |'#[0]'      |'#[0]'      |
      |testData/TC_06.json |'#number'      |testData.title  |testData.description |testData.note |'#null'                  |'#null'                     |'#null'                     |'#null'                     |'#[0]'      |'#[0]'      |
      |testData/TC_07.json |'#number'      |testData.title  |testData.description |'#null'       |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |
      |testData/TC_08.json |'#number'      |testData.title  |testData.description |'#null'       |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |

  Scenario Outline: Add new job successfully with blank title

    * def testData = read('<data>')

    #get all job
    Given path jobTitlePath
    And params { "offset": 0, "sortField": "jt.jobTitleName", "sortOrder": "ASC"}
    And headers { Cookie: '#(cookie)'}
    When method get
    Then status 200

    * def idTitle = jsUtils().getIDOfBlankTitle(response)
    # delete blank title
    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(idTitle)']}
    When method delete
    Then status 200

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    * match response.data.id == <expectedJobId>
    * match response.data.title == <expectedJobTitle>
    * match response.data.description == <expectedDescription>
    * match response.data.note == <expectedNote>
    * match response.data.jobSpecification.id == <expectJobSpecificationId>
    * match response.data.jobSpecification.filename == <expectJobSpecificationName>
    * match response.data.jobSpecification.fileType == <expectJobSpecificationType>
    * match response.data.jobSpecification.fileSize == <expectJobSpecificationSize>
    * match response.meta == <expectedMeta>
    * match response.rels == <expectedRels>

    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200

    Examples:
      |data                | expectedJobId! |expectedJobTitle|expectedDescription  |expectedNote  |expectJobSpecificationId |expectJobSpecificationName  |expectJobSpecificationType  |expectJobSpecificationSize  |expectedMeta|expectedRels|
      |testData/TC_02.json |'#number'       |testData.title  |testData.description |testData.note |'#number'                |testData.specification.name |testData.specification.type |testData.specification.size |'#[0]'      |'#[0]'      |


  Scenario Outline: Add new job unsuccessfully

    * def testData = read('<data>')
    And testData.title = testData.title + jsUtils().getCurrentDate()

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 422

    * match response.error.status == <expectedStatusCode>
    * match response.error.message == <expectedMessage>
    * match response.error.data.invalidParamKeys[0] == <expectedInvalidParamKeys>


    Examples:
      |data                |expectedStatusCode    |expectedMessage      |expectedInvalidParamKeys  |
      |testData/TC_09.json |"422"                 |"Invalid Parameter"  |'title'                   |
      |testData/TC_11.json |"422"                 |"Invalid Parameter"  |'title'                   |
      |testData/TC_12.json |"422"                 |"Invalid Parameter"  |'description'             |
      |testData/TC_13.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_14.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_15.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_16.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_17.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_18.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_19.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_20.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_21.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_22.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_23.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_24.json |"422"                 |"Invalid Parameter"  |'specification'           |
      |testData/TC_25.json |"422"                 |"Invalid Parameter"  |'note'                    |

  Scenario Outline: Add new job unsuccessfully with exited title

    * def testData = read('<data>')
    And testData.title = testData.title + jsUtils().getCurrentDate()

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 200
    And print response.data
    * def id = response.data.id

    Given path jobTitlePath
    And headers {Content-Type : 'application/json', Cookie: '#(cookie)'}
    And request testData
    When method post
    Then status 422

    * match response.error.status == <expectedStatusCode>
    * match response.error.message == <expectedMessage>
    * match response.error.data.invalidParamKeys[0] == <expectedInvalidParamKeys>

    Given path jobTitlePath
    And headers { Cookie: '#(cookie)'}
    And headers {Content-Type : 'application/json'}
    And request { "ids" : ['#(id)']}
    When method delete
    Then status 200


    Examples:
      |data                |expectedStatusCode    |expectedMessage      |expectedInvalidParamKeys  |
      |testData/TC_10.json |"422"                 |"Invalid Parameter"  |'title'                   |
