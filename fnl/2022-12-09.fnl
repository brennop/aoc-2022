(local file (io.input))

(fn view [x] (print ((. (require :fennel) :view) x)))

(local ins [])
(local visited {})
(local dirs {:R [1 0] :L [-1 0] :U [0 -1] :D [0 1]})

;; get distance between two points
(fn dist [[x1 y1] [x2 y2]]
  (math.sqrt (+ (math.pow (- x1 x2) 2) (math.pow (- y1 y2) 2))))

(each [line (file:lines)]
  (let [(d c) (line:match "(.) (%d+)")
        count (tonumber c)
        dir (. dirs d)]
    (for [i 1 count]
      (table.insert ins dir))))

(accumulate [[[hx hy] tails] [[0 0] (fcollect [i 1 2] [0 0])]
             _ [dx dy] (ipairs ins)]
  (let [nx (+ hx dx) ny (+ hy dy)]
    [[nx ny] (accumulate [[[x y] r] [[nx ny] []]
                 _ [tx ty] (ipairs tails)]
      (if (< (dist [x y] [tx ty]) 2)
             [tx ty] [x y]
             ))]))

(print (accumulate [sum 1 _ _ (pairs visited)]
  (+ sum 1)))
