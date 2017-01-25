Strategy
------------
1. Write tests for "normal" items and all of the special items (minus the "Conjured" item)
2. Return from the main `update_quality()` method to a separate method for each type of item e.g. `normal_update_quality(item)` or `aged_brie_update_quality(item)`
