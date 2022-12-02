(local file (io.input))

(print (accumulate [sum 0 line (file:lines)]
         ;; the boob matcher
         (+ sum (match (line:match "(.) (.)")
                  ;; draws
                  (:A :X)
                  4
                  (:B :Y)
                  5
                  (:C :Z)
                  6
                  ;; wins
                  (:C :X)
                  7
                  (:A :Y)
                  8
                  (:B :Z)
                  9
                  ;; lose
                  (:B :X)
                  1
                  (:C :Y)
                  2
                  (:A :Z)
                  3))))
