# riemann-timeseries

An influxdb sink for riemann. This enables riemann to persist events into
Influxdb.

## Directory structure
`riemann-timeseries/` is where the code resides

`influxdb/` and `riemann/` contain the configuration files and data for both
services.

I have included two scripts `start-influxdb` and `start-riemann` to help
starting the services. They are smart to set everything up, so the initial setup
is minimal. You basically just need to run `start-influxdb` to have a running
instance of Influxdb; the same goes for `start-riemann`.

## Usage
The first thing to do is to build an uber jar, so cd into `riemann-timeseries`
and run

```
lein uberjar
```

When that's done. Run `start-influxdb` first, and then run `start-riemann`. You
can take a look at a look at the `start-riemann` and see how I configure the
classpath, and `riemann/riemann.config` to see how to use the store events into
Influxdb.

## License
Copyright © 2014 Marco Yuen

Distributed under the Eclipse Public License either version 1.0 or (at your
option) any later version.
