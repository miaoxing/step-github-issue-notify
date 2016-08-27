# Github issue notify

Create github issue when build failed

# Options

- `token` - The github personal token to create issues https://github.com/settings/tokens
- `repo` - The github repository to create issues

# Example

```yaml
build:
    after-steps:
        - miaoxing/github-issue-notify:
            token: $GITHUB_ISSUE_TOKEN
            repo: username/repo
```

# License

The MIT License (MIT)

# Changelog

## 0.0.1

- Initial release