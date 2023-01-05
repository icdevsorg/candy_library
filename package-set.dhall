let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.6.21-20220215/package-set.dhall sha256:b46f30e811fe5085741be01e126629c2a55d4c3d6ebf49408fb3b4a98e37589b
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