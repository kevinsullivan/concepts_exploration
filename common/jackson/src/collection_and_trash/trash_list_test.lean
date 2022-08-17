import ..implementation.trash_list_nat
import ..implementation.trash_list_bool

open trash

-- function to insert 5 into "pre" collection (list/nat) 
def insert_5 
  (pre : trash_state list list nat) 
  [has_trash list list nat] :=
has_trash.create 5 pre


-- Check to see that it behaves as expected on this case
#reduce insert_5 has_trash.init


-- Operation sequence on initially empty collection
def s0 := @has_trash.init list _ list _ nat _  -- um, ok
def s1 := trash.has_trash.create 3 s0
def s2 := trash.has_trash.create 2 s1
def s3 := trash.has_trash.remove 3 s2
def s4 := trash.has_trash.restore 3 s3
#reduce s0
#reduce s1
#reduce s2
#reduce s3
#reduce s4

def t0 := @has_trash.init list _ list _ bool _
def t1 := has_trash.create tt t0
def t2 := has_trash.create ff t1
def t3 := has_trash.remove tt t2
def t4 := has_trash.restore tt t3
#reduce t0
#reduce t1
#reduce t2
#reduce t3
#reduce t4

-- conceptual confusion? empty trash vs empty collection

