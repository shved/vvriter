# Description

Extremely simple single user reader.

# Install dependencies
```
make install
```

# Authentication

Set the env variable AUTH_KEY and route right to it as `schema://host/<AUTH_KEY>`

# Strating application
```
make run DROPBOX_TOKEN=<oauth token> AUTH_KEY=<your auth key>
```

# Lint and test
```
make lint
make test
```

# Console
```
make console
```
