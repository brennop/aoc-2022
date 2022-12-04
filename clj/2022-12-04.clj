(reduce 
  (fn [sum line]
       (let [[a b c d]
         (vec (map #(Integer/parseInt %) (rest (re-find #"(\d+)-(\d+),(\d+)-(\d+)" line))))]
          (cond 
            (and (>= c a) (<= c b)) (inc sum)
            (and (>= a c) (<= a d)) (inc sum)
            :else sum))) 
  0
     *input*)
