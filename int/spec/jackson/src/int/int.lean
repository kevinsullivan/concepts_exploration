class Int
-- state
(val: int)
-- actions
(get : unit → int)  -- side effect is to get data from back end
(set : int → unit)  -- side effect is to store data to back end
-- op concept
-- get returns val
-- set updates val


-- TODO: how much complexity does it introduce to add a new op to the concept 
-- definition. Try this out with an "init" action.
(init : int := 0)