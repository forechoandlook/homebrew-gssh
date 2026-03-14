# Homebrew Tap for gssh-agent

## Installation

```bash
brew tap forechoandlook/gssh
brew install gssh-agent
```

## Usage

```bash
# Start daemon
brew services start gssh-agent

# Or manually
gssh-daemon &

# Connect SSH
gssh connect -u user -h host -P password

# Execute command
gssh exec "ls -la"
```
