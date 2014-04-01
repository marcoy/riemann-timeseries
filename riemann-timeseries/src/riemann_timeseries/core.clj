(ns riemann-timeseries.core
  (:require [capacitor.core :as i]
            [environ.core :refer [env]]
            [clojure.pprint :refer [pprint print-table]]))


(defn client
  [& {:keys [host port user password db] :as param}]
  (i/make-client param))


(defn ->Influxdb
  [client table]
  (fn [event]
    (i/post-points client table
                   [(-> event
                        (dissoc :time)
                        (dissoc :host)
                        (assoc :tags (clojure.string/join ","
                                                          (:tags event))))])))


(defn -main
  [& args]
  (let [c (i/make-client {:db "riemann"})
        query (str "SELECT * from events")]
    (println (i/get-query c query))))
