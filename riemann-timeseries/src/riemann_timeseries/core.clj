(ns riemann-timeseries.core
  (:require [capacitor.core :as i]
            [environ.core :refer [env]]
            [clojure.pprint :refer [pprint print-table]]))


(defmulti convert class)
(defmethod convert java.lang.Number [v] v)
(defmethod convert java.lang.String [s] s)
(defmethod convert clojure.lang.Keyword [k] (name k))
(defmethod convert java.util.List [xs] (clojure.string/join "," (map str xs)))
(defmethod convert java.util.Map [m] (pr-str m))


(defn sanitize
  [e]
  (loop [ev-keys (keys e)
         result {}]
    (if (seq ev-keys)
      (let [cur-key (first ev-keys)]
        (recur (rest ev-keys)
               (assoc result cur-key (convert (cur-key e)))))
      result)))


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
                        sanitize)])))


(defn -main
  [& args]
  (let [c (i/make-client {:db "riemann"})
        query (str "SELECT * from events")]
    (println (i/get-query c query))))
