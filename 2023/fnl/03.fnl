(local fennel (require :fennel))

(local data (io.read "*a"))

(fn iter [str]
  (values 
    (fn [str start] 
      (let [(init e value) (str:find "(%d+)" start)]
        (if init
          (values (+ e 1) [init e value]))))
    str 0))

(each [s [i e v] (iter data)] (print i e v))
