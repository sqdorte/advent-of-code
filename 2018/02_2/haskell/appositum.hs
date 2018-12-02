import System.Environment

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Usage: ./appositum input.txt"
    (arg:_) -> readFile arg >>= putStrLn . common . lines

common strs = common' x y where
  [x,y] = [x | x <- strs, y <- strs, exactlyOne x y]

common' "" _ = ""
common' _ "" = ""
common' (x:xs) (y:ys)
  | x == y = x : common' xs ys
  | otherwise = common' xs ys

exactlyOne xs ys = length filtered == 1 where
  filtered = filter (not . snd) $
    zipWith (\x y -> (x, x == y)) xs ys
