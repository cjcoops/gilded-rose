require_relative './item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      return if item.name.include?("Sulfuras, Hand of Ragnaros")
      return aged_brie_update_quality(item) if item.name.include?("Aged Brie")
      return backstage_passes_update_quality(item) if item.name.include?("Backstage passes to a TAFKAL80ETC concert")
      normal_update_quality(item)
    end
  end

  private

  def normal_update_quality(item)
    quality_multiplier = (item.sell_in <= 0 ? 2 : 1)
    reduce_quality_or_min(item, 1 * quality_multiplier, 0)
    reduce_sell_in(item)
  end

  def aged_brie_update_quality(item)
    increase_quality_or_max(item, 1, 50)
    reduce_sell_in(item)
  end

  def backstage_passes_update_quality(item)
    if item.sell_in <= 0
      item.quality = 0
    else
      quality_multiplier = (item.sell_in > 10 ? 1 : item.sell_in > 5 ? 2 : 3)
      increase_quality_or_max(item, 1 * quality_multiplier, 50)
    end
    reduce_sell_in(item)
  end

  def reduce_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def increase_quality_or_max(item, n, max)
    change = change_in_quality(item, n)
    item.quality = [item.quality + change,max].min
  end

  def reduce_quality_or_min(item, n, min)
    change = change_in_quality(item, n)
    item.quality = [item.quality - change,min].max
  end

  def change_in_quality(item, n)
    n * (is_conjured?(item) ? 2 : 1)
  end

  def is_conjured?(item)
    item.name.include?("Conjured")
  end

end
