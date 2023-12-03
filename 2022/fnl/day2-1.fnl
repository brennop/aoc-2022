(local file (io.input))

(local matcher {:A {:X 4 :Y 8 :Z 3} :B {:X 1 :Y 5 :Z 9} :C {:X 7 :Y 2 :Z 6}})

(print (accumulate [sum 0 line (file:lines)]
         ;; the boob matcher
         (let [(theirs ours) (line:match "(.) (.)")]
           (+ sum (. matcher theirs ours)))))
