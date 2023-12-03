(require '[clojure.set :as set])

(defn split [s]
  (partition (/ (count s) 2) s))

(defn score [c]
  (let [value (byte c)]
    (- value (if (> value 97) 96 38))))

(->> *input*
   (partition 3) ;; part 2
   ; (map split) ;; part 1
   (map #(map set %))
   (map #(apply set/intersection %))
   (map first)
   (map score)
   (reduce +))
