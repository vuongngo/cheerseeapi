# Cheersee API
* Concept: Create API endpoint with business logic to Gamify Dating
* Tech stack: API with Ruby on Rails, Frontend with Angularjs, Realtime feature with Nodejs

#####Signup
* POST: /api/v1/users
* Params: email, password, password_confirmation, name, gender

#####Signin
* POST: /api/v1/sessions
* Params: email, password

#####Signout
* DELETE: /api/v1/sessions

# Access restrict areas
* Set header 'Authorization' with 'Bearer ' + token

#####Update user
* PUT: /api/v1/users/:id
* Params: email, profile [age, interest, location, avatar]

#####Delete user
* DELETE: /api/v1/users/:id

###Profile endpoints

#####Get profile
* GET: /api/v1/profiles/:id (with :id => userId)

#####Update profile
* PUT: /ap1/v1/profiles/:id
* Params: age, interests, location, avatar

###Contest endpoints

#####Get contests
* GET: /api/v1/contests

#####Post contest
* POST: /api/v1/contests
* Params: post, att (eg: minutes, metters), rule (eg: higher, lowest), ended_at, pic (array), u => [u_id, name, avatar]

#####Update contest
* PUT: /api/v1/contests/:id (with id => contestId)
* Params: post, att, rule, ended_at, :pic

#####Delete contest
* DELETE: /api/v1/contests/:id

###Participation endpoints

#####Get participations
* GET: api/v1/participations

#####Post participation
* POST: api/v1/participations
* Params: post, point, u => [u_id, name, avatar], pic

#####Update participation
* PUT: api/v1/participations/:id (with id => participationId)
* Params: post, point

#####Delete participation
* DELETE: api/v1/participations/:id
