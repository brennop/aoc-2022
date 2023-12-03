(local file (io.input))
(local read-line (file:lines))

(fn all-matches [s patt]
  (table.concat (icollect [m (s:gmatch patt)]
                  m)))

(fn get-common [sacks]
  (accumulate [pattern "%w" _ sack (ipairs sacks)]
    (all-matches sack (.. "[" pattern "]"))))

(fn read-n [n]
  (fn []
    (fcollect [_ 1 n] (read-line))))

(fn get-value [letter]
  (- (letter:byte) (if (letter:match "%l") 96 38)))

(fn split [[s]]
  (let [half (-> s (length) (/ 2))]
    [(s:sub 1 half) (s:sub (+ 1 half))]))

(print (accumulate [sum 0 sacks (read-n 3) &until (= 0 (length sacks))]
         (->> sacks
              ;; (split) ;; uncomment for part 1
              (get-common)
              (get-value)
              (+ sum))))
