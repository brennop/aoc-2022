(local file (io.input))

(fn transpose [lines]
  (fcollect [i 1 (length (. lines 1))]
            (fcollect [j 1 (length lines)] (: (. lines j) :sub i i))))

(local lines (icollect [line (file:lines) &until (= line "")]
               line))

(local transposed (icollect [i stack (ipairs (transpose lines))]
                (if (= (% (- i 2) 4) 0) stack)))

(local initial (icollect [_ stack (ipairs transposed)]
                (table.concat (icollect [_ letter (ipairs stack)]
                  (if (letter:match "%w") letter)))))

(fn parse-line [line]
  (icollect [d (line:gmatch "(%d+)")]
    (tonumber d)))

(local final (accumulate [stacks initial line (file:lines)]
  (let [[n from to] (parse-line line)]
    (icollect [i stack (ipairs stacks)]
      (if (= from i) (string.sub stack (+ n 1))
          (= to i) (.. (string.reverse (string.sub (. stacks from) 1 n)) stack)
          stack)))))

(each [_ d (ipairs final)] (io.write (string.sub d 1 1)))
