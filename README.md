# laravel-sail-ecs

## Local development (Sail)

### ENV configuration

1. Update the **Local port** in `.env`

2. Enable XDebug

-   Set `SAIL_XDEBUG=true`
-   Run `sail build --no-cache`
-   Check `sail php -v`

### Expose the URL to Internet

1. Just need **HTTP**: `sail share` (30 mins)

2. **HTTPS**: use `ngrok http --region=ap 81` (120 mins and [ngrok](https://ngrok.com) makes life much easier)

### Command line

1. Open `.zshrc`, add `alias sail="./vendor/bin/sail"`

2. Replace `php` by `sail`, eg: `sail artisan queue:work`

## Production (ECS)

1. Create an IAM user with Policy:

-   AmazonEC2ContainerRegistryFullAccess
-   AmazonECS_FullAccess

2. Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` into Github repository > Settings > Secrets.

3. Create a bucket via AWS console to upload production .env file (file name should be your_app.env, eg: laravel-ecs-test.env)

4. Fill your parameters in `cfn_parameters.json` then create stack from `cloudformation.yml`.

```
aws cloudformation create-stack \
--stack-name test-larsailecs \
--template-body file://cloudformation.yml \
--parameters file://cfn_parameters.json
```

5. Push your code to branch `main` and boom 🚀.

6. When you make some updates on CloudFormation, please `update-stack`

```
aws cloudformation create-stack \
--stack-name test-larsailecs \
--template-body file://cloudformation.yml \
--parameters file://cfn_parameters.json
```
