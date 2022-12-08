(def data 
  (->> *input*
    (map (fn [line] (map #(Character/digit % 10) line)))
    (mapv vec)))

(defn visible? [row]
  (loop [highest -1
         [x & xs] row
         result []]
    (if (nil? x)
      result
      (if (> x highest)
        (recur x xs (conj result 1))
        (recur highest xs (conj result 0))))))

(defn score [row]
  (loop [[x & xs] row
         result []]
    (if (nil? x)
      result
      (recur xs (conj result
                      (if-let [d (first (keep-indexed #(if (<= x %2) %1) xs))]
                       (inc d)
                       (count xs)))))))

(defn rot-90 [matrix]
  (apply mapv vector (reverse matrix)))

(defn rot-270 [matrix]
  (reverse (apply mapv vector matrix)))

(defn rot-180 [matrix]
  (reverse (mapv reverse matrix)))

(def visible (mapv (partial mapv bit-or)
  (mapv visible? data)
  (rot-180 (mapv visible? (rot-180 data)))
  (rot-90 (mapv visible? (rot-270 data)))
  (rot-270 (mapv visible? (rot-90 data)))))

(def scores (mapv (partial mapv *)
  (mapv score data)
  (rot-180 (mapv score (rot-180 data)))
  (rot-90 (mapv score (rot-270 data)))
  (rot-270 (mapv score (rot-90 data)))))

(->> visible
     flatten
     (remove zero?)
     count)

(->> scores
     flatten
     (apply max))
