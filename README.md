# Practica-haskell
# Practica 1 - Numeros naturales y recursion

**Autor:** Saul
**Materia:** Estructuras Discretas, Facultad de Ciencias, UNAM
**Lenguaje:** Haskell

## Descripcion general

Esta practica tiene tres partes: naturales de Peano, recursion y arboles. En cada una programe funciones en Haskell usando recursion.

## Requisitos

- Tener instalado GHC (el compilador de Haskell), que incluye `ghci`.
- Tener los tres archivos `.hs` en la misma carpeta.

## Como ejecutar cualquier parte

1. Abrir la terminal y entrar a la carpeta donde estan los archivos:

```
cd Documents
```

2. Abrir el archivo que quiero probar en el interprete de Haskell:

```
ghci NombreDelArchivo.hs
```

3. Escribir las pruebas despues del prompt `ghci>`.
4. Si cambio algo en el archivo, lo recargo con `:r` sin cerrar ghci.
5. Para salir escribo `:q`.

## Idea general: recursion

En todas las funciones uso el mismo esquema:

1. Un caso base, que se resuelve directamente.
2. Un caso recursivo, donde la funcion se llama a si misma con un problema mas pequeno.

Como cada llamada se acerca al caso base, la recursion siempre termina.

---

## Parte 1: Naturales de Peano

**Archivo:** `TareadeLaboratorio.hs`

### Que hace

Defini los numeros naturales como los define Peano: solo con un primer elemento, el cero, y una funcion que da el siguiente numero, llamada sucesor. Con esa estructura programe cuatro funciones: pasar de entero a natural, pasar de natural a entero, sumar y multiplicar.

### La estructura de datos

```haskell
data Natural = Cero | S Natural deriving Show
```

Un `Natural` puede tener solo dos formas:

- `Cero`, que es el numero 0.
- `S n`, que es el sucesor de `n`, es decir, `n + 1`.

Por ejemplo, el 3 se escribe `S (S (S Cero))`. Lo pienso como contar con palitos: el valor es la cantidad de `S` que hay antes del `Cero`. El `deriving Show` sirve para que Haskell pueda imprimir los valores.

### Funciones

**a_natural** convierte un entero en `Natural`. Si es 0 regresa `Cero`; si no, pone una `S` y convierte `n - 1`.

```haskell
a_natural :: Int -> Natural
a_natural 0 = Cero
a_natural n = S (a_natural (n - 1))
```

Con el 2: `a_natural 2 = S (S Cero)`. No funciona con enteros negativos porque nunca llega a 0.

**a_entero** hace lo contrario: `Cero` vale 0 y cada `S` suma 1.

```haskell
a_entero :: Natural -> Int
a_entero Cero  = 0
a_entero (S n) = 1 + a_entero n
```

Con `S (S Cero)`: `1 + (1 + 0) = 2`.

**suma_nat** suma dos naturales fijandose solo en el primero. Me base en que 0 + b = b y en que (a + 1) + b = (a + b) + 1. Es decir, le quito una `S` al primero y se la pongo al resultado.

```haskell
suma_nat :: Natural -> Natural -> Natural
suma_nat Cero b  = b
suma_nat (S a) b = S (suma_nat a b)
```

Con 2 + 1:

```
suma_nat (S (S Cero)) (S Cero)
  = S (suma_nat (S Cero) (S Cero))
  = S (S (suma_nat Cero (S Cero)))
  = S (S (S Cero))
```

**mult_nat** multiplica usando la suma. Me base en que 0 * b = 0 y en que (a + 1) * b = b + (a * b). Multiplicar es sumar `b` tantas veces como `S` tenga el primer numero. El guion bajo `_` quiere decir que en ese caso no me importa el segundo argumento.

```haskell
mult_nat :: Natural -> Natural -> Natural
mult_nat Cero _  = Cero
mult_nat (S a) b = suma_nat b (mult_nat a b)
```

Con 2 * 2 el resultado es `S (S (S (S Cero)))`, que es 4.

### Pruebas

```
ghci TareadeLaboratorio.hs
ghci> a_natural 2
S (S Cero)
ghci> a_entero (S (S Cero))
2
ghci> suma_nat (S (S Cero)) (S Cero)
S (S (S Cero))
ghci> mult_nat (S (S Cero)) (S (S Cero))
S (S (S (S Cero)))
ghci> a_entero (a_natural 3)
3
```

La ultima prueba convierte un entero a natural y de regreso, y debe devolver el mismo numero.





---

## Parte 2: Recursion

**Archivo:** `Recursion.hs`

### Que hace

En esta parte programe seis funciones recursivas sobre enteros (`Int`) y listas: Fibonacci, multiplicacion, potencia, factorial, division con residuo y maximo de una lista. En todas escribi primero el caso base y despues el caso recursivo, que reduce el problema a uno mas pequeno.

### Funciones

**fibo** regresa el numero de Fibonacci de un entero. Cada numero es la suma de los dos anteriores, por eso necesito dos casos base: 0 y 1.

```haskell
fibo :: Int -> Int
fibo 0 = 0
fibo 1 = 1
fibo n = fibo (n - 1) + fibo (n - 2)
```

Con el 4: `fibo 4 = fibo 3 + fibo 2 = 2 + 1 = 3`. Es lenta con numeros grandes porque repite calculos.

**a_multiplicacion** multiplica dos enteros sin usar `*` para la recursion. Me base en que n * 0 = 0 y en que n * (m + 1) = n + n * m. Es decir, multiplicar es sumar `n` un total de `m` veces.

```haskell
a_multiplicacion :: Int -> Int -> Int
a_multiplicacion _ 0 = 0
a_multiplicacion n m = n + a_multiplicacion n (m - 1)
```

Con 3 * 2: `3 + (3 + 0) = 6`.

**a_potencia** eleva `n` a la `m`. Me base en que n^0 = 1 y en que n^(m + 1) = n * n^m. El 1 es el neutro de la multiplicacion, por eso es el caso base.

```haskell
a_potencia :: Int -> Int -> Int
a_potencia _ 0 = 1
a_potencia n m = n * a_potencia n (m - 1)
```

Con 2^3: `2 * (2 * (2 * 1)) = 8`.

**a_factorial** calcula n!. Me base en que 0! = 1 y en que (n + 1)! = n! * (n + 1), escrito con `n` en lugar de `n + 1`.

```haskell
a_factorial :: Int -> Int
a_factorial 0 = 1
a_factorial n = n * a_factorial (n - 1)
```

Con 3!: `3 * (2 * (1 * 1)) = 6`.

**divi** regresa un par con el cociente y el residuo. Si `a < b`, el cociente es 0 y el residuo es `a`. Si `a >= b`, le resto `b` una vez, divido lo que queda y le sumo 1 al cociente. Esa suma de 1 es la funcion f(x, r) = (x + 1, r) que pide el enunciado: el residuo no cambia. El `where` le da nombre al resultado de la llamada recursiva para poder usarlo.

```haskell
divi :: Int -> Int -> (Int, Int)
divi a b
  | a < b     = (0, a)
  | otherwise = (c + 1, r)
  where (c, r) = divi (a - b) b
```

Con 7 entre 2:

```
divi 1 2 = (0, 1)
divi 3 2 = (1, 1)
divi 5 2 = (2, 1)
divi 7 2 = (3, 1)
```

Se comprueba porque 7 = 3 * 2 + 1. Si `b` es 0 no termina, porque restar 0 nunca se acerca al caso base.

**maximo** regresa el valor mas grande de una lista. Si la lista tiene un solo elemento, ese es el maximo. Si no, separo la cabeza `x` del resto `xs` y el maximo es el mayor entre `x` y el maximo del resto.

```haskell
maximo :: [Int] -> Int
maximo [x]    = x
maximo (x:xs) = max x (maximo xs)
```

Con `[3,2,5,6,1,1]`:

```
max 3 (max 2 (max 5 (max 6 (max 1 1))))
= max 3 (max 2 (max 5 (max 6 1)))
= max 3 (max 2 (max 5 6))
= max 3 (max 2 6)
= max 3 6
= 6
```

No esta definida para la lista vacia.

### Pruebas

```
ghci Recursion.hs
ghci> fibo 4
3
ghci> a_multiplicacion 3 4
12
ghci> a_potencia 2 3
8
ghci> a_factorial 5
120
ghci> divi 7 2
(3,1)
ghci> maximo [3,2,5,6,1,1]
6
```


---

## Parte 3: Arboles binarios

**Archivo:** `Arboles.hs`

### Que hace

En esta parte defini un arbol binario en Haskell y programe dos funciones sobre el: una que cuenta cuantos nodos tiene y otra que calcula su profundidad.

### La estructura de datos

```haskell
data ArbolB a = Vacio | Nodo a (ArbolB a) (ArbolB a)
  deriving (Eq, Show)
```

Un `ArbolB a` puede tener solo dos formas:

- `Vacio`, que es el arbol sin nada.
- `Nodo x i d`, que es un nodo con un valor `x` y dos hijos: `i` (izquierdo) y `d` (derecho). Los hijos tambien son arboles.

La definicion es recursiva: un arbol se arma con arboles mas pequenos. Lo pienso como una caja que guarda un dato y dos cajas mas, que pueden estar vacias.

La `a` significa que el arbol puede guardar cualquier tipo de dato (numeros, cadenas, etc.). El `deriving (Eq, Show)` permite comparar arboles con `==` e imprimirlos. Por ejemplo, `Nodo "t1" Vacio Vacio` es un arbol de un solo nodo y sin hijos.

El archivo tambien tiene `type Arbin a = ArbolB a`, que es solo otro nombre para el mismo tipo; no lo uso en las funciones.

### Funciones

En las dos funciones escribi un caso para cada forma del arbol: `Vacio` es el caso base y `Nodo` es el caso recursivo, donde llamo a la funcion con el hijo izquierdo y con el derecho. Como los hijos son mas pequenos que el arbol completo, la recursion termina.

**num_elementos** cuenta los nodos del arbol. Un arbol vacio tiene 0 nodos. Un `Nodo` cuenta como 1, mas los nodos del hijo izquierdo, mas los del derecho. El valor que guarda el nodo no importa, por eso lo escribi como `_`.

```haskell
num_elementos :: ArbolB a -> Int
num_elementos Vacio        = 0
num_elementos (Nodo _ i d) = 1 + num_elementos i + num_elementos d
```

**depth** calcula la profundidad, que es el largo del camino mas largo desde la raiz hasta un `Vacio`. Un arbol vacio tiene profundidad 0. Un `Nodo` suma 1 (su propio nivel) a la profundidad del hijo mas profundo. Uso `max` porque me interesa el camino mas largo y no la suma de los dos lados.

```haskell
depth :: ArbolB a -> Int
depth Vacio        = 0
depth (Nodo _ i d) = 1 + max (depth i) (depth d)
```

### Ejemplo paso a paso

Uso este arbol, que tiene el 1 en la raiz, el 2 como hijo izquierdo y nada como hijo derecho:

```haskell
Nodo 1 (Nodo 2 Vacio Vacio) Vacio
```

Numero de nodos:

```
num_elementos (Nodo 1 (Nodo 2 Vacio Vacio) Vacio)
  = 1 + num_elementos (Nodo 2 Vacio Vacio) + num_elementos Vacio
  = 1 + (1 + 0 + 0) + 0
  = 2
```

Profundidad:

```
depth (Nodo 1 (Nodo 2 Vacio Vacio) Vacio)
  = 1 + max (depth (Nodo 2 Vacio Vacio)) (depth Vacio)
  = 1 + max (1 + max 0 0) 0
  = 1 + max 1 0
  = 2
```

### Pruebas

El archivo ya trae un `main` con estas dos pruebas. Se puede compilar y correr asi:

```
ghc Arboles.hs
./Arboles
```

Imprime `2` y `2`. Tambien se puede probar en `ghci`:

```
ghci Arboles.hs
ghci> num_elementos (Nodo 1 (Nodo 2 Vacio Vacio) Vacio)
2
ghci> depth (Nodo 1 (Nodo 2 Vacio Vacio) Vacio)
2
```
