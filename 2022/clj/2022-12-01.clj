(->> *input*
     (reduce (fn [[num arr] line]
          (if (= line "")
            [0 (conj arr num)]
            [(+ num (Integer/parseInt line)) arr]))
        [0 []])
     (second)
     (sort >)
     (take 3) ;; 1 for part 1, 3 for part 2
     (reduce +))
