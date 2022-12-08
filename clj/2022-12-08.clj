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

(->> visible
     flatten
     (remove zero?)
     count)


