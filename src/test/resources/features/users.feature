Feature: Gestión de usuarios

  Background:
    * url 'https://reqres.in'
    * header x-api-key = 'reqres-free-v1'

  Scenario: Obtener usuario existente devuelve datos correctos
    Given path '/api/users/2'
    When method GET
    Then status 200
    And match response.data.id == 2
    And match response.data.email == '#string'
    And match response.data.first_name == '#string'
    And match response.data.last_name == '#string'

  Scenario: Obtener usuario inexistente devuelve 404
    Given path '/api/users/9999'
    When method GET
    Then status 404

  Scenario: Crear usuario devuelve 201 con id
    Given path '/api/users'
    And request { name: 'Diego', job: 'QA Engineer' }
    When method POST
    Then status 201
    And match response.id == '#string'
    And match response.name == 'Diego'
    And match response.job == 'QA Engineer'

  Scenario: Actualizar usuario devuelve 200 con datos modificados
    Given path '/api/users/2'
    And request { name: 'Diego', job: 'Senior QA' }
    When method PUT
    Then status 200
    And match response.name == 'Diego'
    And match response.job == 'Senior QA'

  Scenario: Eliminar usuario devuelve 204
    Given path '/api/users/2'
    When method DELETE
    Then status 204
