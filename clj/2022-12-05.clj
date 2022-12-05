(require '[clojure.string :as string])

(def stack-re #".(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.). .(.).")
(def ins-re #"move (\d+) from (\d+) to (\d+)")

(def initial 
  (->> *input*
       (take-while #(not (empty? %)))
       (drop-last)
       (map #(re-find stack-re %))
       (map rest)
       (apply map list)
       (map (partial filter #(not= " " %)))))

(def lines
  (->> *input*
       (drop-while #(not (empty? %)))
       (drop 1)))

(defn parse-line [line]
  (let [[_ n from to] (re-find ins-re line)]
    [(Integer/parseInt n) (Integer/parseInt from) (Integer/parseInt to)]))

(def final 
  (reduce 
    (fn [stacks line]
      (let [[n from to] (parse-line line)
            from-stack (nth stacks (dec from))
            to-stack (nth stacks (dec to))]
        (-> stacks
            vec
            (assoc (dec from) (drop n from-stack))
            (assoc (dec to) (concat  (reverse (take n from-stack)) to-stack)))))
    initial
    lines))

(apply str (map first final))
