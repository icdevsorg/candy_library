let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.10.0-20230911/package-set.dhall sha256:7bce6afe8b96a8808f66b5b6f7015257d44fc1f3e95add7ced3ccb7ce36e5603
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
      { name = "xtendedNumbers"
      , version = "v1.0.2"
      , repo = "https://github.com/gekctek/motoko_numbers"
      , dependencies = [] : List Text
      }] : List Package

  let overrides = 
  [{name = "base"
         , version = "moc-0.7.4"
         , repo = "https://github.com/dfinity/motoko-base"
         , dependencies = [] : List Text
         }]

in  upstream # additions # overrides