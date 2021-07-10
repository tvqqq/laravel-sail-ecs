# laravel-sail-ecs

## Local development (Sail)

### ENV configuration

1. Update the **Local port** in `.env`

### Expose the URL to Internet

1. Just need **HTTP**: `sail share` (30 mins)

2. **HTTPS**: use `ngrok http --region=ap 81` (120 mins and [ngrok](https://ngrok.com) makes life much easier)

### Command line
1. Open `.zshrc`, then add `alias sail="./vendor/bin/sail"`

2. Replace `php` by `sail`
Ex: `sail artisan queue:work`
## Production (ECS)
