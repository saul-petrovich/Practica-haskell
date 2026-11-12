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
