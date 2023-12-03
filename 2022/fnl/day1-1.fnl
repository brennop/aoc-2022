(local file (io.input))

(fn get-cal []
  (accumulate [sum nil line (file:lines) &until (= line "")]
    (+ (or sum 0) (tonumber line))))

(print (math.max (table.unpack (icollect [v (#get-cal)]
                                 v))))
