import D "mo:base/Debug";
import {test} "mo:test";
import Properties "../src/properties";
import Types "../src/types";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

type Property = Types.Property;
type UpdateShared = Types.UpdateShared;
type Query = Types.Query;

type CandyShared = Types.CandyShared;

// Shared Test Instances
let principal = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
let natValue: Nat = 42;

// Utility function to create properties
func createPropertiesShared() : Types.PropertiesShared {
  return [
    {name = "prop1"; value = #Nat(natValue); immutable = true},
    {name = "prop2"; value = #Principal(principal); immutable = false},
    {name = "prop3"; value = #Class([
      {name = "subclass_prop1"; value = #Nat(natValue); immutable = false}
    ]); immutable = false}
  ];
};


  // Test getPropertiesShared
  test("getPropertiesShared should return specified shared properties", func() {
    let properties = createPropertiesShared();
    let queries: [Query] = [{name="prop1"; next=[];}];
    let result = Properties.getPropertiesShared(properties, queries);
    switch(result) {
      case(#ok(res)) {
        assert(res.size() == 1);
        assert(res[0].name == "prop1");
      };
      case(_) { assert(false); };
    };
  });

  // Test getPropertiesShared with nested queries
  test("getPropertiesShared should return nested shared properties", func() {
    let properties = createPropertiesShared();
    let queries: [Query] = [{name = "prop3"; next = [{name = "subclass_prop1"; next=[]}]}];
    let result = Properties.getPropertiesShared(properties, queries);
    switch(result) {
      case(#ok(res)) {
        assert(res.size() == 1);
        switch(res[0].value) {
          case (#Class(props)) { assert(props.size() == 1); assert(props[0].name == "subclass_prop1"); };
          case (_) { assert(false); };
        };
      };
      case(_) { assert(false); };
    };
  });

  // Test updatePropertiesShared
  test("updatePropertiesShared should update mutable properties", func() {
    let properties = createPropertiesShared();
    let updates: [UpdateShared] = [{name = "prop2"; mode = #Set(#Nat(999))}];
    let result = Properties.updatePropertiesShared(properties, updates);
    switch(result) {
      case(#ok(res)) {
        assert(res.size() == 3);
        assert((res[1]).value == #Nat(999));
      };
      case(_) { assert(false); };
    };
  });

  // Test updatePropertiesShared on immutable property
  test("updatePropertiesShared should not update immutable properties", func() {
    let properties = createPropertiesShared();
    let updates: [UpdateShared] = [{name = "prop1"; mode = #Set(#Nat(999))}];
    let result = Properties.updatePropertiesShared(properties, updates);
    switch(result) {
      case(#err(err)) {
        switch(err) {
          case(#Immutable) { assert(true); };
          case(_) { assert(false); };
        };
      };
      case(_) { assert(false); };
    };
  });

  // Test updatePropertiesShared with non-existent property
  test("updatePropertiesShared should add non-existent properties", func() {
    let properties = createPropertiesShared();
    let updates: [UpdateShared] = [{name = "non_existent"; mode = #Set(#Nat(999))}];
    let result = Properties.updatePropertiesShared(properties, updates);
    switch(result) {
      case(#err(err)) {
        switch(err) {
          case(#NotFound) { assert(false); };
          case(_) { assert(false); };
        };
      };
      case(#ok(val)) {
        switch(val[3].value){
          case(#Nat(val)){
            assert(val == 999);
          };
          case(_) return assert(false);
        };};
    };
  });

  let nestedProperty: Types.PropertyShared = {
  name = "nestedProp";
  value = #Class([ // Nested class inside the property
    {
      name = "subProp1";
      value = #Nat(123);
      immutable = true
    }
  ]);
  immutable = false
};

// Test getProperties uses the same `properties` setup as getPropertiesShared, so omitted for brevity
// ...

// Test getClassPropertyShared
test("getClassPropertyShared should return a specific property from a class if available", func() {
  let classValue: CandyShared = #Class([nestedProperty]);
  let propertyName = "nestedProp";
  let property = Properties.getClassPropertyShared(classValue, propertyName);
  switch (property) {
    case (null) { assert(false); };
    case (?p) {
      assert(p.name == propertyName);
      assert(p.immutable == false);
    };
  };
});

// Test updateProperties
test("updateProperties should update a mutable property within a Candy class", func() {
  var properties = createPropertiesShared();
  let mutablePropName = "prop2";
  let newMutableValue: CandyShared = #Nat(100);
  let updates: [Types.UpdateShared] = [{name = mutablePropName; mode = #Set(newMutableValue)}];
  let result = Properties.updatePropertiesShared(properties, updates);
  switch (result) {
    case (#ok(updatedProperties)) {
      switch(Properties.getClassPropertyShared(#Class(updatedProperties), mutablePropName)){
        case(?value){
          assert(value.value == newMutableValue);
        };
        case(null){
          return assert(false);
        };
      }
      
    };
    case (#err(_)) {
      assert(false);
    };
  };
});

// Test updating an immutable property 
test("updateProperties should not update an immutable property", func() {
  let properties = createPropertiesShared();
  let immutablePropertyName = "prop1";
  let updates: [UpdateShared] = [{name = immutablePropertyName; mode = #Set(#Nat(999))}];
  let result = Properties.updatePropertiesShared(properties, updates);
  switch (result) {
    case (#ok(_)) {
      assert(false); // Should not occur
    };
    case (#err(e)) {
      switch (e) {
        case (#Immutable) {
          assert(true); // Correct error
        };
        case (_) {
          assert(false); // Incorrect error type
        };
      };
    };
  };
});

