-- Here we formally define our "state" concept

universe u

class State (α: Type u)
(val: α)
(fetch : unit → α)  -- side effect is to get data from back end
(store : α → unit)  -- side effect is to store data to back end

-- TODO: think harder about this