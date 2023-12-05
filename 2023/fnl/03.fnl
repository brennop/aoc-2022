(local fennel (require :fennel))

(local data (io.read "*a"))

(local width (data:find "\n"))

(fn get [index]
  ; (print (data:sub index index) index))
  (= index (data:find "[^%d%.\n]" index)))

(fn check [init finish value] 
  (let [left-bound (- init width 1)
        right-bound (+ finish width 1)
        size (+ 1 (length value))]
    (or (faccumulate [symbol? false i left-bound (+ left-bound size)]
                     (or symbol? (get i)))
        (faccumulate [symbol? false i (- right-bound size) right-bound]
                     (or symbol? (get i)))
        (get (+ finish 1))
        (get (- init 1)))))

(fn iter [str]
  (values 
    (fn [str start] 
      (let [(init e value) (str:find "(%d+)" start)]
        (if init
          (values (+ e 1) [init e value]))))
    str 0))

(print (accumulate [sum 0 s [i e v] (iter data)]
  (if (check i e v) (+ sum v) sum)))
