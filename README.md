Strategy
------------
1. Write tests for "normal" items and all of the special items (minus the "Conjured" item) considering edge cases e.g. quality reducing by 2 while quality is 1 where quality can not be below 0.
2. Return from the main `update_quality()` method to a separate method for each type of item e.g. `normal_update_quality(item)` or `aged_brie_update_quality(item)`
3. Along the way DRY out any common methods e.g. `reduce_sell_in(item, n)` to reduce an items sell_in value by n.
