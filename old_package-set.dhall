let vessel_package_set =
      https://github.com/dfinity/vessel-package-set/releases/download/mo-0.8.3-20230224/package-set.dhall
let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let
  -- This is where you can add your own packages to the package-set
  additions =
    [{ name = "candid"
      , version = "v1.0.1"
      , repo = "https://github.com/gekctek/motoko_candid"
      , dependencies = ["xtendedNumbers", "base"] : List Text
      },
      { name = "candy_0_1_12"
      , version = "v0.1.12"
      , repo = "https://github.com/icdevs/candy_library"
      , dependencies = ["base"] : List Text
      },
      { name = "xtendedNumbers"
      , version = "v1.0.2"
      , repo = "https://github.com/gekctek/motoko_numbers"
      , dependencies = [] : List Text
      },
      { name = "stablebuffer"
      , repo = "https://github.com/skilesare/StableBuffer"
      , version = "v0.2.0"
      , dependencies = [ "base"]
      },
      { name = "base", repo = "https://github.com/dfinity/motoko-base.git", version = "moc-0.8.1", dependencies = []: List Text },
      { name = "map7"
      , repo = "https://github.com/ZhenyaUsenko/motoko-hash-map"
      , version = "v7.0.0"
      , dependencies = [ "base"]
      },] : List Package

  

in vessel_package_set # additions