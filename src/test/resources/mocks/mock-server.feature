Feature: Mock server para login y usuarios

  # --- LOGIN ---
  Scenario: pathMatches('/api/login') && methodIs('post')
    * def req = karate.request
    * if (req.email == 'eve.holt@reqres.in' && req.password == 'cityslicka') {response = { token: 'fake-token-123' } status = 200} else { response = { error: 'Invalid credentials' }status = 400}

  # --- GET USER BY ID ---
  Scenario: pathMatches('/api/users/[0-9]+') && methodIs('get')
    * def id = karate.match().group(1)
    * if (id == '2') { response = { data: { id: 2, email: 'janet.weaver@reqres.in', first_name: 'Janet', last_name: 'Weaver', avatar: 'https://mock/avatar.png' } } status = 200 } else { response = {} status = 404 }

  # --- LIST USERS PAGINATED ---
  Scenario: pathMatches('/api/users') && methodIs('get')
    * def params = karate.params || {}
    * def page = params.page
    * def response = (page == '2') ? { page: 2, data: [{ id: 7, email: 'michael.lawson@reqres.in', first_name: 'Michael', last_name: 'Lawson', avatar: 'https://mock/avatar.png' }] } : { data: [] }
    * def status = 200



  # --- CREATE USER ---
  Scenario: pathMatches('/api/users') && methodIs('post')
    * def req = karate.request
    * print req
    * def response = (req.name && req.job) ? { id: '101', name: req.name, job: req.job, createdAt: '2025-09-28T10:00:00Z' } : { error: 'Missing data' }
    * def status = (req.name && req.job) ? 201 : 400

  # --- UPDATE USER ---
  Scenario: pathMatches('/api/users') && methodIs('post')
    * def req = karate.request
    * print req
    * def hasBody = req && req.name && req.job
    * def response = hasBody ? { id: '101', name: req.name, job: req.job, createdAt: '2025-09-28T10:00:00Z' } : { error: 'Missing data' }
    * def status = hasBody ? 201 : 400



  # --- DELETE USER ---
  Scenario: pathMatches('/api/users/[0-9]+') && methodIs('delete')
    * def status = 204

