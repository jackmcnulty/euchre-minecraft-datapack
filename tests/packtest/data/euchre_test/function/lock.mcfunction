# Tables are global state (one per world), so tests that build one take turns:
#   await not data storage euchre_test:lock {held:1b}
#   function euchre_test:lock
#   ... test ...
#   function euchre_test:unlock
# Test functions run one at a time, and code after a satisfied await runs in the
# same tick, so no other test can slip in between the check and the set.
data modify storage euchre_test:lock held set value 1b
