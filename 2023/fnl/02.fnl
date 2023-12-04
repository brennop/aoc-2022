(local file (io.input))

(local colors {:red 12 :green 13 :blue 14})

(fn power [data]
  (let [[red green blue]
    (accumulate [[red green blue] [0 0 0] number color (data:gmatch "(%d+) (%w+)")]
      (match color
        :red [(math.max red (tonumber number)) green blue]
        :green [red (math.max green (tonumber number)) blue]
        :blue [red green (math.max blue (tonumber number))]))]
    (* red green blue)))

(fn check-valid [data]
  (accumulate [valid true number color (data:gmatch "(%d+) (%w+)")]
    (and valid (<= (tonumber number) (. colors color)))))

(fn part1 [line]
  (let [(id data) (line:match "Game (%d+): (.*)")]
    (if (check-valid data) (tonumber id) 0)))

(fn part2 [line]
  (let [(id data) (line:match "Game (%d+): (.*)")]
    (power data)))

(print (accumulate [sum 0 line (file:lines)]
  (+ sum (part2 line))))

