# Github issue notify

Create github issue when build failed

# Options

- `token` - The github personal token to create issues https://github.com/settings/tokens
- `repo` - The github repository to create issues
- `title` - The issue title, `%title%` would be replaced to the last git commit message
- `error_file` - The file contains error message, it will create an issues, if the content is not empty, even the build has passed

# Example

```yaml
build:
  after-steps:
    - miaoxing/github-issue-notify:
        token: $GITHUB_ISSUE_TOKEN
        repo: username/repo
        title: "Build failed: %title%"
        error_file: error.txt
```

# License

The MIT License (MIT)

# Changelog

## 0.0.12

- Fix JSON format error when data contain `\` character

## 0.0.11

- Change assignee from author to committer

## 0.0.10

- Fix JSON format error when data contain single quote character

## 0.0.9

- Fix JSON format error when data contain tab character

## 0.0.8

- Use `$WERCKER_GIT_COMMIT` to receive git logs

## 0.0.7

- Add `title` parameter

## 0.0.6

- Fix var typo

## 0.0.5

- Fix exit code error, add more debug info

## 0.0.4

- Add `error_file` parameter

## 0.0.3

- Fix shellcheck issues

## 0.0.1

- Initial release