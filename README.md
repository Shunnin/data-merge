# DATA MERGE

## CircleCI

https://app.circleci.com/pipelines/github/Shunnin/data-merge

## Staging Env

https://d-data-merge.herokuapp.com/api/hotels

## Required softwares

- rbenv
- Ruby 2.6.6
- Rails 6.0.1
- PostgreSQL 12.x.x
- Redis 4.0

## Setup

- Install dependencies in Gemfile:

```bash
bundle install
```

- Run sidekiq:

```bash
bundle exec sidekiq
```

- Run test:

```bash
bundle exec rspec
```

- Run Rubocop:

```bash
bundle exec rubocop
```

- Run Rails server:

```bash
bundle exec rails s
```

## Demo

* Procuring the data:
```bash
  # Access the Sidekiq url
  https://d-data-merge.herokuapp.com/sidekiq/cron

  # Trigger cron job to fetch new data from other supplier
  procuring_data_supplier_task
```

* Access the url: `https://d-data-merge.herokuapp.com/api/hotels` fetch hotel data

* Search by hotel id:
```bash
  # Run rails c
  query_param = { hotels: ['hotel_id'] }.to_query

  # Access the link
  "https://d-data-merge.herokuapp.com/api/hotels?#{query_param}"
```

* Search by destination id:
```bash
  # Run rails c
  query_param = { destination: ['destination_id'] }.to_query

  # Access the link
  "https://d-data-merge.herokuapp.com/api/hotels?#{query_param}"
```

* Search by destination id & hotel id:
```bash
  # Run rails c
  query_param = { hotels: ['hotel_id'], destination: ['destination_id'] }.to_query

  # Access the link
  "https://d-data-merge.herokuapp.com/api/hotels?#{query_param}"
```