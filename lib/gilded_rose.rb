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

  def normal_update_quality(item)
    if item.sell_in <= 0
      reduce_quality_or_min(item, 2, 0)
    else
      reduce_quality_or_min(item, 1, 0)
    end
    reduce_sell_in(item)
  end

  def aged_brie_update_quality(item)
    increase_quality_or_max(item, 1, 50)
    reduce_sell_in(item)
  end

  def backstage_passes_update_quality(item)
    if item.sell_in > 10
      increase_quality_or_max(item, 1, 50)
    elsif item.sell_in > 5
      increase_quality_or_max(item, 2, 50)
    elsif item.sell_in > 0
      increase_quality_or_max(item, 3, 50)
    else
      item.quality = 0
    end
    reduce_sell_in(item)
  end

  private

  def reduce_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def increase_quality_or_max(item, n, max)
    quality_multiplier = is_conjured?(item) ? 2 : 1
    item.quality = [item.quality + n * quality_multiplier,max].min
  end

  def reduce_quality_or_min(item, n, min)
    quality_multiplier = is_conjured?(item) ? 2 : 1
    item.quality = [item.quality - n * quality_multiplier,min].max
  end

  def is_conjured?(item)
    item.name.include?("Conjured")
  end

end
