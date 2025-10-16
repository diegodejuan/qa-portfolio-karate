Feature: Mock server para login y usuarios

  # --- LOGIN ---
  Scenario: pathMatches('/api/login') && methodIs('post')
    * def req = karate.request
    * print 'login req:', req
    * def body = (req && req.email) ? req : (req && req.body ? (typeof req.body == 'string' ? JSON.parse(req.body) : req.body) : {})
    * def valid = body.email == 'eve.holt@reqres.in' && body.password == 'cityslicka'
    * eval if (valid) { response = { token: 'fake-token-123' }; status = 200; } else { response = { error: 'Invalid credentials' }; status = 400; }

  # --- GET USER BY ID ---
  Scenario: pathMatches('/api/users/[0-9]+') && methodIs('get')
    * def req = karate.request
    * def parts = (req && req.path) ? req.path.split('/') : []
    * def id = parts.length > 0 ? parts[parts.length - 1] : ''
    * print 'get id:', id
    * eval if (id == '1' || id == '2' || id == '3') { response = { data: { id: parseInt(id), email: 'user' + id + '@reqres.in', first_name: 'First' + id, last_name: 'Last' + id, avatar: 'https://mock/avatar.png' } }; status = 200; } else { response = {}; status = 404; }

  # --- LIST USERS PAGINATED ---
  Scenario: pathMatches('/api/users') && methodIs('get')
    * def req = karate.request
    * def params = (req && req.params) ? req.params : (karate.params || {})
    * def page = params.page
    * eval if (page == '2') { var arr = []; for (var i = 0; i < 6; i++) { arr.push({ id: 6 + i + 1, email: 'user' + (6 + i + 1) + '@reqres.in', first_name: 'First' + (6 + i + 1), last_name: 'Last' + (6 + i + 1), avatar: 'https://mock/avatar.png' }); } response = { page: 2, data: arr }; status = 200; } else { response = { data: [] }; status = 200; }

  # --- CREATE USER ---
  Scenario: pathMatches('/api/users') && methodIs('post')
    * def req = karate.request
    * print 'create req:', req
    * def body = (req && req.name) ? req : (req && req.body ? (typeof req.body == 'string' ? JSON.parse(req.body) : req.body) : {})
    * eval if (body && body.name && body.job) { response = { id: String(Math.floor(Math.random() * 10000) + 100), name: body.name, job: body.job, createdAt: '2025-09-28T10:00:00Z' }; status = 201; } else { response = { error: 'Missing data' }; status = 400; }

  # --- UPDATE USER ---
  Scenario: pathMatches('/api/users/[0-9]+') && methodIs('put')
    * def req = karate.request
    * def parts = (req && req.path) ? req.path.split('/') : []
    * def id = parts.length > 0 ? parts[parts.length - 1] : ''
    * print 'updating id:', id, 'body:', req
    * def body = (req && req.name) ? req : (req && req.body ? (typeof req.body == 'string' ? JSON.parse(req.body) : req.body) : {})
    * eval if (body && body.name && body.job) { response = { id: id, name: body.name, job: body.job, updatedAt: '2025-09-28T10:00:00Z' }; status = 200; } else { response = { error: 'Missing data' }; status = 400; }

  # --- DELETE USER ---
  Scenario: pathMatches('/api/users/[0-9]+') && methodIs('delete')
    * def req = karate.request
    * def parts = (req && req.path) ? req.path.split('/') : []
    * def id = parts.length > 0 ? parts[parts.length - 1] : ''
    * print 'delete id:', id
    * eval status = 204