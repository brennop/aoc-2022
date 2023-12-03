(local data (io.read))

(fn recur [n]
  (let [[a b c d] (fcollect [i n (+ n 3)] i)]
    (if (or 
          (string.match (string.sub data a a) (.. "[" (string.sub data b d) "]"))
          (string.match (string.sub data a b) (.. "[" (string.sub data c d) "]"))
          (string.match (string.sub data a c) (.. "[" (string.sub data d d) "]")))
        (recur (+ n 1))
        n)))

(print (+ (recur 1) 3))
