(def window 4) ;; 4 for part 1, 14 for part 2

(->> 
  (map (partial subs (first *input*)) (range window))
  (apply map list)
  (take-while #(not (apply distinct? %)))
  count
  (+ window))
  
