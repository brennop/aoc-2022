(defn is-digit [c]
  (<= (int \0) (int c) (int \9)))

(defn parse-line [line]
  (str 
    (first (filter is-digit line))
    (last (filter is-digit line))))

(->> *input*
     (map parse-line)
     (map #(Integer/parseInt %))
     (reduce +))

