kjorskra
========

Little gem that can figure out where you should vote.

Give it your kennitala and it will tell you where you should vote in the Icelandic elections
on the 27th.

## Usage

``` ruby
require "kjorskra"
Kjorskra::Kjorskra.new("kennitala").get_registeration() =>
  { :name          => "Name",
    :address       => "Address",
    :district      => "District",
    :municipality  => "Municipality",
    :polling_place => "Polling place",
    :devision      => "Devision" }
```
