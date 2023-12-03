(local file (io.input))

(fn tail [list] (match list [_ & rest] rest))

(fn first-parser [line n]
  (match line
    (where [x & rest] (x:match "%d")) (tonumber x)
    ["o" "n" "e" & _] 1
    ["t" "w" "o" & _] 2
    ["t" "h" "r" "e" "e" & _] 3
    ["f" "o" "u" "r" & _] 4
    ["f" "i" "v" "e" & _] 5
    ["s" "i" "x" & _] 6
    ["s" "e" "v" "e" "n" & _] 7
    ["e" "i" "g" "h" "t" & _] 8
    ["n" "i" "n" "e" & _] 9
    [x & rest] (first-parser rest n)
    [] n
    )
  )

(fn last-parser [line n]
  (match line
    (where [x & rest] (x:match "%d")) (last-parser rest (tonumber x))
    ["o" "n" "e" & _] (last-parser (tail line) 1)
    ["t" "w" "o" & _] (last-parser (tail line) 2)
    ["t" "h" "r" "e" "e" & _] (last-parser (tail line) 3)
    ["f" "o" "u" "r" & _] (last-parser (tail line) 4)
    ["f" "i" "v" "e" & _] (last-parser (tail line) 5)
    ["s" "i" "x" & _] (last-parser (tail line) 6)
    ["s" "e" "v" "e" "n" & _] (last-parser (tail line) 7)
    ["e" "i" "g" "h" "t" & _] (last-parser (tail line) 8)
    ["n" "i" "n" "e" & _] (last-parser (tail line) 9)
    [x & rest] (last-parser rest n)
    [] n
    )
  )

(print (accumulate [sum 0 line (file:lines)]
  (let [chars (icollect [c (line:gmatch ".")] c)]
    (-> (.. (first-parser chars 0) (last-parser chars 0))
        (tonumber)
        (+ sum)))))
