function fn() {
  var config = {};
  var env = karate.env || 'dev';

  if (env == 'mock') {
    var port = 8080;
    karate.log('>>> Levantando mock en puerto:', port);
    karate.start('classpath:mocks/mock-server.feature');
    config.baseUrl = 'http://localhost:' + port;
  } else {
    config.baseUrl = 'https://reqres.in';
  }

  config.headers = { 'x-api-key': 'reqres-free-v1' };
  return config;
}
