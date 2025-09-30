function fn() {
  var config = {};
  config.baseUrl = 'https://reqres.in';
  config.headers = { 'x-api-key': 'reqres-free-v1' };
  karate.log('>>> cargando config baseUrl =', config.baseUrl);
  return config;
}
