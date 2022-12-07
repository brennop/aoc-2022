(require '[clojure.string :as str])

(defn reducer [[position tree] line]
  (let [[a b c] (str/split line #" ")]
    (println position)
    (println tree)
    (cond 
      (= line "$ ls") [position tree]
      (= line "$ cd ..") [(pop position) tree]
      (= (subs line 0 4) "$ cd") [(conj position c) tree]
      (= (subs line 0 2) "dir") [position (assoc-in tree (conj position b) {})]
      :else [position (assoc-in tree (conj position b) a)])))

(reduce reducer [[] {:/ {}}] *input*)
