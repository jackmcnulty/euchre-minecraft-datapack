# Every 5 seconds: recount active tables. Markers in chunks that weren't loaded
# when the pack loaded (e.g. right after a server start) are picked up here.
function euchre:recount_active
schedule function euchre:heartbeat 100t
