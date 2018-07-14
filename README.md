# rubyfucoin

A basic blockchain server written in Ruby to understand the concepts.

## Test for a full resolution flow

If you want to test the full service using two servers and resolution, you will need 3 shells and then type:

### Shell 1
```
ruby lib/app.rb
```
### Shell 2
```
ruby lib/app.rb -p 4568
```

### Shell 3
```
curl -X GET http://localhost:4567/create
curl -X GET http://localhost:4568/create
curl -X GET 'http://localhost:4567/add_transaction?from=Mike&to=Tommy&amount=100'
curl -X GET 'http://localhost:4568/add_transaction?from=Mike&to=Tommy&amount=100'
curl -X GET 'http://localhost:4567/add_transaction?from=Mike&to=John&amount=100'
curl -X GET http://localhost:4567/mine
curl -X GET http://localhost:4568/mine
curl -X GET http://localhost:4568/resolve
```