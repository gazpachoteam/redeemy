# Redeemy

Use your points to finance any social project.

## Contributing Requirements

**Create a branch**

```
$ git checkout master
$ git pull
$ git checkout -b xx-short-description
```

The name of the branch should start with the number of the issue, followed by max three keywords that describe the issue (e.g. `23-fix-homepage`, `56-change-font`, etc.).

### Writing good commit messages

A commit message has a first line, a blank line and an optional body. For example (taken from the Rails repository):

```
Make flash messages cookie compatible with Rails 4

In #xxx we removed the discard key from the session hash used to flash
messages and that broke compatibility with Rails 4 applications because they
try to map in the discarded flash messages and it returns nil.

Fixes #xxx.
```

Notice that the first line and the body are capitalized. The first line should be 50 characters or less and should start with a verb (e.g. make, fix, create, implement, add, etc.).

The body should be wrapper to 72 characters and you can reference any issue and [use keywords to close them](https://help.github.com/articles/closing-issues-via-commit-messages/).

**Tip:** Think about sending an e-mail to a colleague where the first line is the subject of the email, and the body is the body of the e-mail.
