# Tables (one per world) and the euchre:debug rig hook are global state, so
# tests that use them take turns:
#   await not data storage euchre_test:lock {held:1b}
#   function euchre_test:lock
#   ... test ...
#   function euchre_test:unlock
# Test functions run one at a time, and code after a satisfied await runs in the
# same tick, so no other test can slip in between the check and the set.
data modify storage euchre_test:lock held set value 1b
# A test that fails while holding the lock never releases it, so later lock
# users time out too: when several table tests fail, fix the first one first.
