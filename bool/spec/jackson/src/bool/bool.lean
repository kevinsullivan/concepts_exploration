class Bool
-- state
(val: bool)
-- actions
(get : unit → bool)  -- side effect is to get data from back end
(set : bool → unit)  -- side effect is to store data to back end
-- op concept
-- get returns val
-- set updates val


-- TODO: how much complexity does it introduce to add a new op to the concept 
-- definition. Try this out with an "init" action.
(init : bool := 0)