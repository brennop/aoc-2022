(local file (io.input))

(local tree {:/ {}})

(fn tokenize [line]
  (icollect [t (line:gmatch "[^%s]+")]
    t))

(fn get [tbl key]
  (let [(cur rest) (key:match "(.-/)(.*)")
        value (. tbl cur)]
    (if (= rest "") value (get value rest))))

(accumulate [position "" line (file:lines)]
  (match (tokenize line)
    ["$" :cd ".."] (position:match "(.*/).*/")
    ["$" :cd "/"] "/"
    ["$" :cd dir] (.. position dir "/")
    ["$" :ls] position
    [:dir dir] (do
                 (tset (get tree position) (.. dir "/") {})
                 position)
    [size name] (do
                  (tset (get tree position) name (tonumber size))
                  position)))

(local data [])

(fn dfs [tbl]
  (accumulate [sum 0 name value (pairs tbl)]
    (match (type value)
      :table (let [size (dfs value)]
               (table.insert data size)
               (+ sum size))
      :number (+ sum value))))

(local total (dfs tree))
(local needed (- 30000000 (- 70000000 total)))

(print (accumulate [sum 0 _ value (ipairs data)]
         (if (<= value 100000) (+ sum value) sum)))

(local available (icollect [_ value (ipairs data)]
  (if (>= value needed) value nil)))

(table.sort available)

(print (. available 1))
