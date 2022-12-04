(defn get-values [line]
  (vec (map #(Integer/parseInt %) (rest (re-find #"(\d+)-(\d+),(\d+)-(\d+)" line)))))

(defn reducer [sum line]
  (let [[a b c d] (get-values line)]
          (cond
            (and (>= c a) (<= c b)) (inc sum)
            (and (>= a c) (<= a d)) (inc sum)
            :else sum)))

(reduce reducer 0 *input*)
