Feature: Login de usuario

  Background:
    * url 'https://reqres.in'
    * header x-api-key = 'reqres-free-v1'

  Scenario Outline: Login válido devuelve token
    Given path '/api/login'
    And request { email: <email>, password: <password> }
    When method POST
    Then status 200
    And match response == { token: '#string' }

    Examples:
      | email                | password |
      | eve.holt@reqres.in   | cityslicka |

  Scenario: Login inválido devuelve error
    Given path '/api/login'
    And request { email: 'test@test.com' }
    When method POST
    Then status 400
    And match response == { error: '#string' }
