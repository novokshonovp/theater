# README


Steps are necessary to get the
application up and running.

* Ruby version
`2.6.5`


* Database creation and initialization
`bundle exec rake db:create db:migrate`


* How to run the test suite

`RAILS_ENV=test bundle exec rake db:create db:migrate`

`bundle exec rspec --format doc`

* Usage example

```
curl -X POST -H "Content-Type: application/json" -d '{"name":"name1", "start_date":"19.02.2025", "end_date":"25.02.2025"}' localhost:3000/show
{"id":2,"name":"name1","schedule":"19.02.2025-25.02.2025"}

curl -X POST -H "Content-Type: application/json" -d '{"name":"name2", "start_date":"25.02.2025", "end_date":"25.02.2025"}' localhost:3000/show
{"base":"Date reserved"}

curl localhost:3000/shows
[{"id":2,"name":"name1","schedule":"19.02.2025-26.02.2025"}]

curl -X DELETE localhost:3000/shows/2
{"id":1}

```