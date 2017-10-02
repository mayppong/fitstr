# Fitstr

[![Build Status](https://travis-ci.org/mayppong/fitstr.svg?branch=travis-ci)](https://travis-ci.org/mayppong/fitstr)

# Run Locally with Docker
Fitstr includes a `docker-compose.yml` file.

  - Install the necessary dependencies `mix deps.get`
  - Migrate the database by running `mix ecto.setup`
  - Start the docker web container by running `docker-compose up web`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# Testing
Similarly, Fitstr includes a docker-compose service container for testing as well. Simply run `docker-compose up test`.
