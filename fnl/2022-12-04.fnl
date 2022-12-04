(local file (io.input))

(fn get-values [str]
  (icollect [k (str:gmatch "(%d+)")]
    (tonumber k)))

(print (accumulate [sum 0 line (file:lines)]
    (match (get-values line)
      (where [a b c d] (and (<= a c) (>= b d))) (+ sum 1)
      (where [a b c d] (and (<= c a) (>= d b))) (+ sum 1)
      _ sum)))

