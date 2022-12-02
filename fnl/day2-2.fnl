(local file (io.input))

(local matcher {:X {:A 3 :B 1 :C 2} :Y {:A 4 :B 5 :C 6} :Z {:A 8 :B 9 :C 7}})

(print (accumulate [sum 0 line (file:lines)]
         ;; the boob matcher
         (let [(theirs ours) (line:match "(.) (.)")]
           (+ sum (. matcher ours theirs)))))

