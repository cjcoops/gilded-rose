# Gilded Rose Kata

My solution to the [Gilded Rose Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata) in Ruby.

Strategy
------------
* Write tests for "normal" items and all of the special items (minus the "Conjured" items) considering edge cases e.g. quality reducing by 2 while quality is 1 where quality can not be below 0.

* Return from the main `update_quality()` method to a separate method for each type of item e.g. `normal_update_quality(item)` or `aged_brie_update_quality(item)`

* Along the way DRY out any common methods e.g. `reduce_sell_in(item)` to reduce an items sell_in value

* When all refactored methods are working delete the old if-else logic to check all is working.

* DRY out methods which require increasing/reducing quality by n but to a max/min:

```ruby
def increase_quality_or_max(item, n, max)
  item.quality = [item.quality + n,max].min
end

def reduce_quality_or_min(item, n, min)
  item.quality = [item.quality - n,min].max
end
```
* Give methods which change the quality a change variable which is dependent on whether the item is conjured or not.

```ruby
def reduce_quality_or_min(item, n, min)
  change = change_in_quality(item, n)
  item.quality = [item.quality - change,min].max
end

def change_in_quality(item, n)
  n * (is_conjured?(item) ? 2 : 1)
end
```
* Use a quality multiplier to determine how much the change the quality by when it is based on the sell in value

```ruby
def normal_update_quality(item)
  quality_multiplier = (item.sell_in <= 0 ? 2 : 1)
  reduce_quality_or_min(item, 1 * quality_multiplier, 0)
  reduce_sell_in(item)
end
```
