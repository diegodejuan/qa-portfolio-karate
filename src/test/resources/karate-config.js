function fn() {
  var config = {};
  var env = karate.env || 'dev';

  if (env == 'mock') {
    var requestedPort = 8080;
    karate.log('>>> Solicitado mock en puerto:', requestedPort);
    // karate.start acepta sólo 1 argumento en esta versión; devuelve un objeto server
    var server = karate.start('classpath:mocks/mock-server.feature');
    // intentar usar el puerto solicitado si el server lo expone o usar el asignado
    var port = (server && server.port) ? server.port : requestedPort;
    karate.log('>>> Mock iniciado en puerto:', port);
    config.baseUrl = 'http://localhost:' + port;
  } else {
    config.baseUrl = 'https://reqres.in';
  }

  config.headers = { 'x-api-key': 'reqres-free-v1' };
  return config;
}
