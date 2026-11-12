-- Practica 1: Numeros naturales (Peano)
-- Cero es el 0 y S es la funcion sucesor

data Natural = Cero | S Natural deriving Show

-- 1. Entero -> Natural
a_natural :: Int -> Natural
a_natural 0 = Cero
a_natural n = S (a_natural (n - 1))

-- 2. Natural -> Entero
a_entero :: Natural -> Int
a_entero Cero  = 0
a_entero (S n) = 1 + a_entero n

-- 3. Suma: Cero + b = b ; S a + b = S (a + b)
suma_nat :: Natural -> Natural -> Natural
suma_nat Cero b  = b
suma_nat (S a) b = S (suma_nat a b)

-- 4. Multiplicacion: Cero * b = Cero ; S a * b = b + (a * b)
mult_nat :: Natural -> Natural -> Natural
mult_nat Cero _  = Cero
mult_nat (S a) b = suma_nat b (mult_nat a b)
