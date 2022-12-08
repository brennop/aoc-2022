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

(defn rot [matrix]
  (apply mapv vector (reverse matrix)))

(->> data
     (iterate rot)
     (take 4)
     (mapv #(mapv visible? %))
     (reduce #(mapv (partial mapv bit-or) %2 (rot %1)))
     flatten
     (remove zero?)
     count)

(->> data
     (iterate rot)
     (take 4)
     (mapv (partial mapv score))
     (reduce #(mapv (partial mapv *) %2 (rot %1)))
     flatten
     (reduce max))
