let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.10.0-20230911/package-set.dhall sha256:7bce6afe8b96a8808f66b5b6f7015257d44fc1f3e95add7ced3ccb7ce36e5603
let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let
  -- This is where you can add your own packages to the package-set
  additions =
    [] : List Package

let
  {- This is where you can override existing packages in the package-set

     For example, if you wanted to use version `v2.0.0` of the foo library:
     let overrides = [
         { name = "foo"
         , version = "v2.0.0"
         , repo = "https://github.com/bar/foo"
         , dependencies = [] : List Text
         }
     ]
  -}
  overrides =
    [] : List Package

in  upstream # additions # overrides
