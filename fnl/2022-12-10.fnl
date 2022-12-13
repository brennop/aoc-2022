(local get-next (io.lines))

(local cycles (fcollect [i 1 220] i))

(fn view [x]
  (print ((. (require :fennel) :view) x)))

(fn test [x]
  (if (= (% (- x 20) 40) 0) 1 0))

(local [_ _ _ ans]
       (accumulate [[state y x sum] [:ready 1 1 0] _ cycle (ipairs cycles)]
         (let [strength (* cycle x)
               factor (test cycle)
               next-sum (+ sum (* strength factor))]
           (match state
             :waiting [:ready y y next-sum]
             :ready (let [line (.. (get-next) " ")
                          (a b) (line:match "(.-) (.*)")
                          dx (tonumber b)]
                      (match a
                        :noop [:ready y x next-sum]
                        :addx [:waiting (+ y dx) x next-sum]))))))

(print ans)
