let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.10.0-20230911/package-set.dhall sha256:6833f571fdfdb714eb7a788f91ffd1333e912093714bcc5b1de416cfe8bdf0b8
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
