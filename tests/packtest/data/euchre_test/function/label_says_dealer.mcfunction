# As a seat label: succeeds if it shows the "Dealer" line. A text component
# list is stored as its first part with the rest under `extra`, so check both.
execute if data entity @s text.extra[{text:"\nDealer"}] run return 1
execute if data entity @s text[{text:"\nDealer"}] run return 1
return fail
