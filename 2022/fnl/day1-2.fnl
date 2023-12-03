(local file (io.input))

(fn get-cal []
  (accumulate [sum nil line (file:lines) &until (= line "")]
    (+ (or sum 0) (tonumber line))))

(local data (icollect [v (#get-cal)]
              v))

(table.sort data (fn [a b]
                   (> a b)))

(print (accumulate [sum 0 i v (ipairs data) &until (> i 3)]
         (+ sum v)))
