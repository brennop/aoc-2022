(defn get-values [line]
  (->> line
    (re-find #"(\d+)-(\d+),(\d+)-(\d+)")
    (rest)
    (map #(Integer/parseInt %))))

(defn reducer [sum line]
  (let [[a b c d] (get-values line)]
    (+ sum (if (and (<= a d) (<= c b)) 1 0))))

(reduce reducer 0 *input*)
