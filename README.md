# XHProf Docker Image

This is a Docker image that has the [XHProf PHP profiler](https://github.com/phacility/xhprof) installed and is ready to serve the XHProf UI.

The image is [hosted on Docker Hub as tuimedia/xhprof-docker](https://hub.docker.com/r/tuimedia/xhprof-docker/) and the [code is on GitHub](https://github.com/tuimedia/xhprof-docker).

We use it in development by mounting XHProf profiles into the `/profiles` directory - i.e. with Docker Compose:

```yml
    xhprof:
        image: tuimedia/xhprof-docker:0.9.4
        volumes:
            - ./path-to-our-profiles:/profiles
        ports:
            - "80:80"
```

## How to name profile files

To use XHProf UI the profiles must be:

* named `run.type.xhprof`
* `run` must a hexadecimal digit that returns true when passed to ctype_xdigit
* `type` must be present
* The run and type must be separated by a dot
* The file extension must be xhprof

For example, we use code similar to this:

```php
    xhprof_enable(XHPROF_FLAGS_MEMORY + XHPROF_FLAGS_CPU);

    .... the application runs ...

    $run = time();
    $type = "my-app-1";
    $filename = "/var/www/profiles/$run.$type.xhprof";
    file_put_contents($filename, serialize(xhprof_disable()));`
```