# Dude

**Dude** is our very own [Lita] bot. It does things with Slack.

## Development

* Initial setup: `bin/setup`
* Running dude: `bundle exec lita`

_config/settings.yml_ can be used in development and won't be checked into git. Feel free to add secrets here as needed
for testing.

## Production

Secrets are stored using [ejson]. They should be added to _secrets.production.ejson_ and encrypted before committing.

[Lita]: https://www.lita.io
[ejson]: https://github.com/Shopify/ejson
