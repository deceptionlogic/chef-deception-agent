# Example Chef Recipe for Deception Logic

## Configuration

config.json

```json
{
    "run_list": [
        "recipe[deceptionagent::default]"
    ],
    "attributes":
    {
        "deceptionagent":
        {
            "key_id": "foo",
            "secret_key": "bar",
            "log_file_retention": "10"
        }
    }
}
```

## Deploy

```shell
chef-apply config.json
```
