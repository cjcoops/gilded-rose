class GildedRose

  SPECIAL_ITEMS = ["Aged Brie", "Conjured Aged Brie",
                    "Sulfuras, Hand of Ragnaros",
                      "Backstage passes to a TAFKAL80ETC concert"]

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      return normal_update_quality(item) unless SPECIAL_ITEMS.include?(item.name)
      return aged_brie_update_quality(item) if item.name.include?("Aged Brie")
      return backstage_passes_update_quality(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"
    end
  end

  def normal_update_quality(item)
    quality_multiplier = is_conjured?(item) ? 2 : 1

    if item.sell_in <= 0
      reduce_quality_or_min(item, 2 * quality_multiplier, 0)
    else
      reduce_quality_or_min(item, 1 * quality_multiplier, 0)
    end
    reduce_sell_in(item)
  end

  def aged_brie_update_quality(item)
    quality_multiplier = is_conjured?(item) ? 2 : 1
    increase_quality_or_max(item, 1 * quality_multiplier, 50)
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
    item.quality = [item.quality + n,max].min
  end

  def reduce_quality_or_min(item, n, min)
    item.quality = [item.quality - n,min].max
  end

  def is_conjured?(item)
    item.name.include?("Conjured")
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
