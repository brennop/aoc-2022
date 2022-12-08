(local file (io.input))

(local fennel (require :fennel))
(fn view [x]
  (print (fennel.view x)))

(fn transpose [lines]
  (fcollect [i 1 (length (. lines 1))]
    (fcollect [j 1 (length lines)]
      (. (. lines j) i))))

(local data
       (icollect [line (file:lines)]
         (fcollect [i 1 (length line)] (tonumber (string.sub line i i)))))

(local tdata (transpose data))

(local hmax (icollect [_ v (ipairs data)] (math.max (table.unpack v))))
(local vmax (icollect [_ v (ipairs tdata)] (math.max (table.unpack v))))

(local left (icollect [_ v (ipairs data)]
             (icollect [_ x (ipairs v) &until ]
               )))
(view data)
(view hmax)
(view vmax)
