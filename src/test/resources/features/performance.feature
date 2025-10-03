Feature: Pruebas básicas de performance

  Background:
    * url baseUrl
    * configure headers = headers

  Scenario: Tiempo de respuesta aceptable
    Given path '/api/users'
    When method GET
    Then status 200
    And assert responseTime < 2000