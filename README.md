makefiles
======

Makefiles managed with Github.

Require (local):
* GNU make.
* wget
* rsync
* ssh

Current Supported language:
* golang
  - cross-build: respect `GOOS`, `GOARCH`
  - remote-deploy via rsync
  - remote-run via ssh


#### Get started

1. Download `GNUmakefile`.

``` bash
cd $WORKING_DIR_TO_RUN_MAKE
wget quar.github.io/makefiles/GNUmakefile
```

2. get help of "Auto" detect language

``` bash
make # or `make help`
```

relevant `<lang>.mk` file should be auto-downloaded

3. push to *remote host* (via `rsync`)

``` bash
make push
```

4. execute on *remote host* and echo back output

``` bash
make run-remote
```

#### Customize

* Specify language

``` bash
make CC_LANG=go
```

* Specify *remote host*

``` bash
make push REMOTE_HOST=hostname
```

``` bash
make run_remote REMOTE_HOST=hostname
```

* Specify *remote dir* (default to `~/_test_`)

``` bash
make push REMOTE_DIR='~/target_folder'
```

``` bash
make run_remote REMOTE_DIR='~/target_folder'
```

