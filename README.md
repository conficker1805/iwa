## Setup to run on localhost

* Clone source code from github.
```
git clone git@github.com:conficker1805/iwa.git
```
* Install ruby: `rvm install "ruby-2.7.1"`
* Run `bundle install`
* Run `rake db:seed`
* Run `rails s`
* Access `http://localhost:3000`
* Run unit tests: `rspec`

## What is included in this assignment

**Backend:**
* Using Ruby on rails as backend. Version ruby-2.7.1, rails 6.0.3.2.  
* Using pg for database migrations.
* Using Json Web Token for authentication via API.
* Builing API that can versioning in future.
* Using `rspec` for unit testing (controllers, models, endpoints).

**Fontend**
* Using Bootstrap, jquery as front end frameworks.  

## How to test Web app
* Access http://iwa-webapp.herokuapp.com/
* Login as Teacher (username/password): teacher@example.com/12345678

## How to test API
**Postman:**
From Postman app, click `Import` - `Import from a link` - Paste the url below for importing
[https://www.getpostman.com/collections/99a82589e2a90ab402bd](https://www.getpostman.com/collections/99a82589e2a90ab402bd)

**Curl:**
* Sign in
```
curl --location --request POST 'localhost:3000/api/v1/users/sign_in' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Content-Type: text/plain' \
--data-raw '{
	"credentials": {
		"email": "student@example.com",
		"password": "12345678"
	}
}'
```
* Fetch list of available Tests  
`token` from endpoint **Sign In**
```
curl --location --request GET 'localhost:3000/api/v1/tests' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: token' \
--data-raw ''
```
* Fetch a Test
`token` from endpoint **Sign In**  
`:id` is test id from endpoint **Fetch list of available Tests**
```
curl --location --request GET 'localhost:3000/api/v1/tests/:id' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: token' \
--data-raw ''
```
* Submit a set of Answers (this endpoint allways return "saved succesfully" if user signed in)  
`token` from endpoint **Sign In**
```
curl --location --request POST 'localhost:3000/api/v1/submissions' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: token' \
--header 'Content-Type: text/plain' \
--data-raw '{
	"submission": {
		"test_id": 9,
		"questions": [
			{
				"question_id": 8,
				"answer_ids": [9]
			}
		]
	}
}'
```
