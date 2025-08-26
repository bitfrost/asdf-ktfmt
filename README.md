# asdf-ktfmt

[![GitHub release](https://img.shields.io/github/release/facebook/ktfmt?sort=semver)](https://github.com/facebook/ktfmt/releases/)
[![Build](https://github.com/facebook/ktfmt/workflows/Build%20and%20Test/badge.svg)](https://github.com/facebook/ktfmt/actions/workflows/build_and_test.yml)

[ktfmt](https://github.com/facebook/ktfmt) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl` or `wget`, `git`
- Java 11 or later (required by ktfmt)

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

# Set a version globally (on your ~/.tool-versions file)
asdf global ktfmt latest

# Now ktfmt commands are available
ktfmt --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Usage

Once installed, you can use ktfmt just like the regular command-line tool:

```shell
# Format a single file with default (Meta) style
ktfmt MyFile.kt

# Format with Kotlin official style (4-space indent)
ktfmt --kotlinlang-style src/

# Format with Google style
ktfmt --google-style src/

# Format with Meta style (explicit)
ktfmt --meta-style src/

# Check formatting without making changes
ktfmt --dry-run src/

# Show help
ktfmt --help

# Show version
ktfmt --version
```

### Available Styles

ktfmt supports three formatting styles:

1. **Meta style** (default): 2-space indent, follows Meta's Kotlin conventions
2. **Kotlin official style** (`--kotlinlang-style`): 4-space indent, follows official Kotlin conventions
3. **Google style** (`--google-style`): 2-space indent, follows Google's Java conventions adapted for Kotlin

### Integration with IDEs

ktfmt can be integrated with various IDEs:

- **IntelliJ IDEA/Android Studio**: Install the [ktfmt plugin](https://plugins.jetbrains.com/plugin/14912-ktfmt)
- **VS Code**: Use with Kotlin language server or format on save
- **Vim/Neovim**: Use with formatters or language servers

### Pre-commit Hooks

You can use ktfmt with [pre-commit](https://pre-commit.com/) hooks. See the [language-formatters-pre-commit-hooks](https://github.com/macisamuele/language-formatters-pre-commit-hooks) repository for setup instructions.

## Configuration

ktfmt follows a philosophy of minimal configuration. The tool is designed to enforce consistent formatting without extensive customization options. The main configuration choice is selecting one of the three supported styles.

For projects that need to approximate ktfmt's formatting rules during development, you can use the `.editorconfig` files provided in the [ktfmt documentation](https://github.com/facebook/ktfmt/tree/main/docs/editorconfig).

## Examples

### Format a single file
```shell
ktfmt src/main/kotlin/MyClass.kt
```

### Format all Kotlin files in a directory
```shell
ktfmt src/
```

### Check if files are properly formatted (CI/CD)
```shell
ktfmt --dry-run src/
if [ $? -ne 0 ]; then
  echo "Code is not properly formatted"
  exit 1
fi
```

### Format with specific style
```shell
# Use Kotlin official style (4-space indent)
ktfmt --kotlinlang-style src/

# Use Google style
ktfmt --google-style src/
```

## Troubleshooting

### Java not found
If you get an error about Java not being found:

```shell
Error: Java is required to run ktfmt but was not found in PATH
Please install Java 11 or later
```

Make sure you have Java 11 or later installed and available in your PATH:

```shell
java -version
```

You can install Java using asdf as well:

```shell
asdf plugin add java
asdf install java latest
asdf global java latest
```

### Version compatibility
ktfmt requires Java 11 or later. If you're using an older Java version, you'll need to upgrade.

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/your-username/asdf-ktfmt/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Your Name](https://github.com/your-username/)

## About ktfmt

ktfmt is a program that pretty-prints (formats) Kotlin code, based on [google-java-format](https://github.com/google/google-java-format). It's developed by Facebook and follows the principle of minimal configuration to ensure consistent code formatting across teams and projects.

Key features:
- **Deterministic formatting**: Output is independent of input formatting
- **Minimal configuration**: Reduces bikeshedding about code style
- **Multiple styles**: Supports Meta, Google, and Kotlin official styles
- **Fast**: Built on the proven google-java-format engine
- **IDE integration**: Available as plugins for major IDEs

For more information, visit the [official ktfmt repository](https://github.com/facebook/ktfmt).