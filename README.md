Strategy
------------
1. Write tests for "normal" items and all of the special items (minus the "Conjured" items) considering edge cases e.g. quality reducing by 2 while quality is 1 where quality can not be below 0.

2. Return from the main `update_quality()` method to a separate method for each type of item e.g. `normal_update_quality(item)` or `aged_brie_update_quality(item)`

3. Along the way DRY out any common methods e.g. `reduce_sell_in(item)` to reduce an items sell_in value

4. When all refactored methods are working delete the old if-else logic to check all is working.

5. DRY out methods which require increasing/reducing quality by n but to a max/min:

```ruby
def increase_quality_or_max(item, n, max)
  item.quality = [item.quality + n,max].min
end

def reduce_quality_or_min(item, n, min)
  item.quality = [item.quality - n,min].max
end
```
