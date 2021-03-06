module ParseSpec (spec) where

import Test.Hspec
import Parse
import Samples
import SampleItems

spec :: Spec
spec =  do
    describe "parseItems" $
        it "changes a string to a list of items" $
            parseItemsTest itemString `shouldBe`
                Right sampleInventory

    describe "parseExits" $ do
        it "changes a file/string to a list of exits" $
            parseExits sampleMapExitsGood `shouldBe`
                Right sampleExits
        it "tells you the error if bad input" $ 
            pendingWith "Dunno how to test this?"

    describe "parsePlaces" $ do
        context "all places have one exit" $
            it "changes a file/string to a list of places" $
                parsePlaces sampleMap `shouldBe`
                    Right samplePlaces
        context "mix of exits" $
            it "changes the file to a list of places" $
                parsePlaces sampleMap2 `shouldBe`
                    Right samplePlaces2

    describe "parseDictionary" $ do
        it "changes a file/string to a list of definitions" $
            parseDictionary sampleMap `shouldBe`
                Right sampleDefinitions
        context "mix of exits" $
            it "still works" $
                parseDictionary sampleMap2 `shouldBe`
                    Right sampleMap2Defs
        it "tells you the error if bad input" $
            pendingWith "Dunno how to test."

