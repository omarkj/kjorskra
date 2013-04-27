# -*- coding: utf-8 -*-
require "kjorskra"

describe "Kjorskra::Kjorskra" do

  it "should not raise an error" do
    lambda {
      Kjorskra::Kjorskra.new("1701487469")
    }.should_not raise_error
  end

  it "should not raise an error" do
    lambda {
      Kjorskra::Kjorskra.new("170148-7469")
    }.should_not raise_error
  end

  it "should fail" do
    lambda {
      Kjorskra::Kjorskra.new("1701487")
    }.should raise_error
  end

  it "should fetch information from the webpage" do
      Kjorskra::Kjorskra.new("1701487469").get_registeration()
      .should eql({ :name => "Davíð Oddsson",
                    :address => "Fáfnisnes 12",
                    :district => "Reykjavíkurkjördæmi suður",
                    :municipality => "Reykjavík",
                    :polling_place => "Hagaskóli",
                    :devision => "2" })
  end
end
