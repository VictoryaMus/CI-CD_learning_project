# CI-CD_learning_project
A training project demonstrating the full CI/CD cycle for a simple C program:
build, code style check, integration tests, and automatic deployment to a remote virtual machine via GitLab CI/CD

## Program Description

`DO` is a console utility written in C that takes one argument (a number from 1 to 6) and outputs the corresponding string.

| Argument | Output |
|---|---|
| 1 | `Learning to Linux` |
| 2 | `Learning to work with Network` |
| 3 | `Learning to Monitoring` |
| 4 | `Learning to extra Monitoring` |
| 5 | `Learning to Docker` |
| 6 | `Learning to CI/CD` |

If the number of arguments is incorrect, `Bad number of arguments!` is displayed (return code `-1`). If the value is incorrect — `Bad number!` (return code `-2`).

## CI/CD pipeline

The pipeline consists of four stages:

| Stage | What it does |
|---|---|
| `build` | Builds `DO` using `make`, saves the binary as an artifact (retention period: 30 days) |
| `codestyle` | Checks the formatting of `main.c` using `clang-format --dry-run --Werror` |
| `test` | Runs integration tests (`tests.sh`), checks the output and return codes |
| `deploy` | **Run manually** after all previous stages have been successfully completed. Copies `DO` to the second virtual machine using `scp` and makes it executable using `ssh` |

### Requirements for deployment

- A second virtual machine with Ubuntu and a running SSH server.
- Passwordless SSH access from the runner machine to the second virtual machine.
- GitLab CI/CD variables: `SSH_PRIVATE_KEY` (File type) and `DEPLOY_HOST` (IP of the second virtual machine).
- The user on the second virtual machine has `sudo` privileges without entering a password for the `mv` and `chmod` commands.

## Local run

```bash
cd code-samples
make
./DO 1        # Learning to work with Linux
./DO 7        # Incorrect number!
./DO          # Incorrect number of arguments!
make clean
```
