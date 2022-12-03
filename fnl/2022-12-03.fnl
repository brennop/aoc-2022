(local file (io.input))
(local read-line (file:lines))

(fn all-matches [s patt]
  (table.concat (icollect [m (s:gmatch patt)] m)))

(fn get-common [sacks]
  (accumulate [pattern "%w"
               _ sack (ipairs sacks)]
    (all-matches sack (.. "[" pattern "]"))))

(fn read-n [n]
  (fn [] 
    (fcollect [_ 1 n]
      (read-line))))

(fn get-value [letter]
  (- (letter:byte) (if (letter:match "%l") 96 38)))

; (print (accumulate [sum 0 line (file:lines)]
;          (let [len (/ (length line) 2)
;                letter (line:match (.. "[" (string.sub line 1 len) "]")
;                                     (+ len 1))]
;            (+ sum (- (letter:byte) (if (letter:match "%l") 96 38))))))

(print (accumulate [sum 0 
            sacks (read-n 3) &until (= 0 (length sacks))]
  (->> sacks
       (get-common)
       (get-value)
       (+ sum))))
