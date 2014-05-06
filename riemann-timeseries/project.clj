(defproject riemann-timeseries "0.1.0-SNAPSHOT"

  :description "An influxdb sink for riemann"

  :url "https://github.com/marcoy/riemann-timeseries"

  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}

  :repl-options {:init (require '[capacitor.core :as i]
                                '[capacitor.async :as ia]
                                '[org.httpkit.client :as http]
                                '[cheshire.core :as json]
                                '[environ.core :as env])}

  :plugins [[lein-environ "0.5.0"]]

  :dependencies [[org.clojure/clojure "1.6.0"]
                 ; [riemann "0.2.5"]
                 [http-kit "2.1.18"]
                 [environ "0.5.0"]
                 [cheshire "5.3.1"]
                 [capacitor "0.2.2"]]

  :main riemann-timeseries.core)
