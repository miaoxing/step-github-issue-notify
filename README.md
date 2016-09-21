# Github issue notify

Create github issue when build failed

# Options

- `token` - The github personal token to create issues https://github.com/settings/tokens
- `repo` - The github repository to create issues
- `error_file` - The file contains error message, it will create an issues, if the content is not empty, even the build has passed

# Example

```yaml
build:
  after-steps:
    - miaoxing/github-issue-notify:
        token: $GITHUB_ISSUE_TOKEN
        repo: username/repo
        error_file: error.txt
```

# License

The MIT License (MIT)

# Changelog

## 0.0.3

- Fix shellcheck issues

## 0.0.1

- Initial release