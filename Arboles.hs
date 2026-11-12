-- Practica: Arboles binarios

data ArbolB a = Vacio | Nodo a (ArbolB a) (ArbolB a)
  deriving (Eq, Show)

type Arbin a = ArbolB a

-- 1. Numero de nodos del arbol
num_elementos :: ArbolB a -> Int
num_elementos Vacio        = 0
num_elementos (Nodo _ i d) = 1 + num_elementos i + num_elementos d

-- 2. Profundidad de un arbol
depth :: ArbolB a -> Int
depth Vacio        = 0
depth (Nodo _ i d) = 1 + max (depth i) (depth d)

-- Pruebas directas
main :: IO ()
main = do
  print (num_elementos (Nodo 1 (Nodo 2 Vacio Vacio) Vacio))
  print (depth (Nodo 1 (Nodo 2 Vacio Vacio) Vacio))
