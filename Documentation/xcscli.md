#  `xcscli`

The executable `xcscli` provides a command line interface to the Xcode Server API. To execute from the command line (without building a 
binary version), you can use the `swift run` command from the root directory. For instance:

```bash
$ swift run xcscli --help
```

The subcommand include:

#### ping

Performs a HTTP GET on the `/ping` endpoint. Will output 'OK' if successful.

```bash
$ swift run xcscli ping fully.qualified.domain.name
```

#### versions

Performs a HTTP GET on the `/versions` endpoint. This contains versioning information about the API, Operating System, and Installed 
Xcode.

```bash
$ swift run xcscli versions fully.qualified.domain.name
```

#### bots

Performs a HTTP GET on the `/bots` endpoint. Without any additional options this will return a collection of all the Xcode Bots on the 
server. A `--path` option can be specified for additional information. A single Bot is targeted by specifying the `--id` argument.

*Paths:*

* **stats**: General statistics information about a single Bot.

* **integrations**: The last (up to) 10 integrations for the specific Bot.

* **run**: Triggers a new integration for the specific Bot.

#### integrations

Performs a HTTP GET on the `/integrations` endpoint. A unique identifier must be supplied with `--id/-i`. `--path` is available to 
additional resources.

*Paths*:

* **commits**: The source control history leading to the Integration.

* **issues**: Issues that are identified as new/resolved for the Integration.

* **coverage**: Unit testing coverage data (can take a while).

#### store

On Apple platforms this command will download and persist data from a requested server.

* **info**: Retrieves versioning information about a persistence store (model version)

* **sync**: Initiates a sync for a specific server, retrieving Bots and their associated Integrations.

* **delete-server**: Removes the data for a single Xcode Server from the persistence store.

* **purge**: Remote the local persistence store from disk.
