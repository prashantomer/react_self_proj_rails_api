# Compartir Espacios API

This project is only the JSON based API of the compartir espacios app. The app itself is
made up of this API server and a standalone frontend client (single page application)

It's implemented as a stateless server, and we use [JWT](https://jwt.io) for authentication.
We're not versioning this API, so every client will need to be kept up to date. At the moment we're
only contemplating one: the web client. There's a possibility of a ReactNative client in the
future.

## How do I set this up?

Clone the repository in your local machine:

```
git clone git@bitbucket.org:compartirespacios/compartir_espacios_api.git
cd compartir_espacios_api
```

Run `bundle install` to install all the gems we are using.

Next, copy `.env.example` to `.env` and set your environment variables there.You'll need to
set `DATABASE_USERNAME` and `DATABASE_PASSWORD` in the `.env` file. In order to allow
the app to send emails, add some SMTP server configuration. You can use gmail for development purposes,
but we'll configure this to use Mailpost in staging / production.

You should now be ready to create your database and migrate it:

```
rails db:create
rails db:migrate
rails db:seed
```

## GIT branch policy

We're going to keep `master` stable and do our development in the `develop` branch. Master is protected and
we should not be able to push to master. Although we can push to `develop`, it's encouraged that we do so
via feature branching and merge requests.

## Testing

We're focusing on unit and integration tests. Let's try to keep tests up to date :rocket:. To run the tests,
simply:

```
bundle exec rails test
```

## Deployment

TODO
