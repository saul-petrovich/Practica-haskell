-- Practica de Recursion

-- 1. Numero de Fibonacci. Ejemplo: fibo 4 = 3
-- Casos base: 0 y 1
fibo :: Int -> Int
fibo 0 = 0
fibo 1 = 1
fibo n = fibo (n - 1) + fibo (n - 2)

-- 2. Multiplicacion de forma recursiva
-- n * 0 = 0
-- n * (m + 1) = n + n * m
a_multiplicacion :: Int -> Int -> Int
a_multiplicacion _ 0 = 0
a_multiplicacion n m = n + a_multiplicacion n (m - 1)

-- 3. Potencia de forma recursiva
-- n^0 = 1
-- n^(m + 1) = n * n^m
a_potencia :: Int -> Int -> Int
a_potencia _ 0 = 1
a_potencia n m = n * a_potencia n (m - 1)

-- 4. Factorial de forma recursiva
-- 0! = 1
-- (n + 1)! = n! * (n + 1)
a_factorial :: Int -> Int
a_factorial 0 = 1
a_factorial n = n * a_factorial (n - 1)

-- 5. Division con residuo
-- Si a < b el resultado es (0, a)
-- Si a >= b se aplica f(x, r) = (x + 1, r) a divi (a - b) b
-- El bloque where da nombre al resultado de la llamada recursiva
divi :: Int -> Int -> (Int, Int)
divi a b
  | a < b     = (0, a)
  | otherwise = (c + 1, r)
  where
    (c, r) = divi (a - b) b

-- 6. Maximo de una lista de enteros
-- [x] es una lista con un solo elemento
-- (x:xs) separa la cabeza x del resto xs
-- max x (maximo xs) compara la cabeza con el maximo del resto
maximo :: [Int] -> Int
maximo [x]    = x
maximo (x:xs) = max x (maximo xs)
