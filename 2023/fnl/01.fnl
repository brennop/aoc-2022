(local file (io.input))

(fn first [list] (. list 1))
(fn last [list] (. list (length list)))

(fn parse-line [line]
  (let [digits (icollect [c (line:gmatch ".")] (c:match "%d"))]
    (table.concat [(first digits) (last digits)])))

(print (accumulate [sum 0 line (file:lines)]
  (-> line
    (parse-line)
    (tonumber)
    (+ sum)
  )))
