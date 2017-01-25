require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe "normal item" do

      it "reduces quality by 1" do
        items = [Item.new("normal", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 9
      end

      it "reduces sellin by 1" do
        items = [Item.new("normal", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
      end

      it "reduces quality a twice as fast after sellin reaches 0" do
        items = [Item.new("normal", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end

      it "quality can not go below zero" do
        items = [Item.new("normal", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end

    describe "aged brie" do

      it "increases quality by 1" do
        items = [Item.new("Aged Brie", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 11
      end

      it "reduces sellin by 1" do
        items = [Item.new("Aged Brie", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
      end
      
      it "quality can not go above 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

    end

  end

end
