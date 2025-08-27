# asdf-ktfmt

[ktfmt](https://github.com/facebook/ktfmt) plugin for the [asdf version manager](https://asdf-vm.com).

## Install

Plugin:

```shell
asdf plugin add ktfmt https://github.com/your-username/asdf-ktfmt.git
```

ktfmt:

```shell
# Show all installable versions
asdf list-all ktfmt

# Install specific version
asdf install ktfmt latest

# Set a version globally
asdf global ktfmt latest
```

## Usage

For detailed usage instructions, formatting options, and configuration, see the [official ktfmt documentation](https://github.com/facebook/ktfmt).

## Dependencies

- `bash`, `curl` or `wget`, `git`
- Java 11 or later (required by ktfmt)

## License

See [LICENSE](LICENSE)