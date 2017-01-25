class GildedRose

  SPECIAL_ITEMS = ["Aged Brie",
                    "Sulfuras, Hand of Ragnaros",
                      "Backstage passes to a TAFKAL80ETC concert"]

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|

      return normal_update_quality(item) unless SPECIAL_ITEMS.include?(item.name)

      return aged_brie_update_quality(item) if item.name == "Aged Brie"

      return backstage_passes_update_quality(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"

    end
  end

  def normal_update_quality(item)
    if item.quality > 0
      if item.sell_in <= 0
        item.quality = [item.quality - 2,0].max
      else
        item.quality = item.quality - 1
      end
    end
    reduce_sell_in(item, 1)
  end

  def aged_brie_update_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
    reduce_sell_in(item, 1)
  end

  def backstage_passes_update_quality(item)
    if item.sell_in > 10
      item.quality = [item.quality + 1,50].min
    elsif item.sell_in > 5
      item.quality = [item.quality + 2,50].min
    elsif item.sell_in > 0
      item.quality = [item.quality + 3,50].min
    else
      item.quality = 0
    end
    reduce_sell_in(item, 1)
  end

  private

  def reduce_sell_in(item, n)
    item.sell_in = item.sell_in - n
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
