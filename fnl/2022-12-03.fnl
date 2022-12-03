(local file (io.input))

(print (accumulate [sum 0 line (file:lines)]
         (let [len (/ (length line) 2)
               letter (line:match (.. "[" (string.sub line 1 len) "]")
                                    (+ len 1))]
           (+ sum (- (letter:byte) (if (letter:match "%l") 96 38))))))
