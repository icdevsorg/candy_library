///////////////////////////////
//
// ©2021 @aramakme
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///////////////////////////////

import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Types "types";

module {

    type PropertiesUnstable = Types.PropertiesUnstable;
    type Query = Types.Query;
    type PropertyError = Types.PropertyError;
    type UpdateUnstable = Types.UpdateUnstable;
    type Property = Types.Property;
    type PropertyUnstable = Types.PropertyUnstable;
    type CandyValue = Types.CandyValue;
    type Properties = Types.Properties;
    type Update = Types.Update;

   private func toPropertyUnstableMap(ps : PropertiesUnstable) : HashMap.HashMap<Text,PropertyUnstable> {
            
            let m = HashMap.HashMap<Text,PropertyUnstable>(ps.size(), Text.equal, Text.hash);
            for (property in ps.vals()) {
                m.put(property.name, property);
            };
            m;
        };

        private func fromPropertyUnstableMap(m : HashMap.HashMap<Text,PropertyUnstable>) : PropertiesUnstable {
            
            var ps : PropertiesUnstable = [];
            for ((_, p) in m.entries()) {
                ps := Array.append(ps, [p]);
            };
            ps;
        };


        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
        public func getPropertiesUnstable(properties : PropertiesUnstable, qs : [Query]) : Result.Result<PropertiesUnstable, PropertyError> {
            let m               = toPropertyUnstableMap(properties);
            var ps : PropertiesUnstable = [];
            for (q in qs.vals()) {
                switch (m.get(q.name)) {
                    case (null) {
                        // Query contained an unknown property.
                        return #err(#NotFound);
                    };
                    case (? p)  {
                        switch (p.value) {
                            case (#Class(c)) {
                                if (q.next.size() == 0) {
                                    // Return every sub-attribute attribute.
                                    ps := Array.append(ps, [p]);
                                } else {
                                    let sps = switch (getPropertiesUnstable(c, q.next)) {
                                        case (#err(e)) { return #err(e); };
                                        case (#ok(v))  { v; };
                                    };
                                    
                                    ps := Array.append(ps, [{
                                        name      = p.name;
                                        value     = #Class(sps);
                                        immutable = p.immutable;
                                    }]);
                                };
                            };
                            case (other) {
                                // Not possible to get sub-attribute of a non-class property.
                                if (q.next.size() != 0) {
                                    return #err(#NotFound);
                                };
                                ps := Array.append(ps, [p]);
                            };
                        }
                    };
                };
            };
            #ok(ps);
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
        public func updatePropertiesUnstable(properties : PropertiesUnstable, us : [UpdateUnstable]) : Result.Result<PropertiesUnstable, PropertyError> {
            let m = toPropertyUnstableMap(properties);
            for (u in us.vals()) {
                switch (m.get(u.name)) {
                    case (null) {
                        // Update contained an unknown property, so it gets created.
                        switch (u.mode) {
                            case (#Next(sus)) {
                                let sps = switch(updatePropertiesUnstable([], sus)) {
                                    case (#err(e)) { return #err(e); };
                                    case (#ok(v))  { v; };
                                };
                                
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = #Class(sps);
                                    immutable = false;
                                });
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                    case (? p)  {
                        // Can not update immutable property.
                        if (p.immutable) {
                            return #err(#Immutable);
                        };
                        switch (u.mode) {
                            case (#Next(sus)) {
                                switch (p.value) {
                                    case (#Class(c)) {
                                        let sps = switch(updatePropertiesUnstable(c, sus)) {
                                            case (#err(e)) { return #err(e); };
                                            case (#ok(v))  { v; };
                                        };
                                        
                                        m.put(u.name, {
                                            name      = p.name;
                                            value     = #Class(sps);
                                            immutable = false;
                                        });
                                    };
                                    case (other) {
                                        // Not possible to update sub-attribute of a non-class property.
                                        return #err(#NotFound);
                                    };
                                };
                                return #err(#NotFound);
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = p.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                };
            };
            
            #ok(fromPropertyUnstableMap(m));
        };


        

        public func getClassProperty(val: CandyValue, name : Text) : ?Property{
            
            switch(val){
                case(#Class(val)){
                    for(thisItem in val.vals()){
                        if(thisItem.name == name){
                            return ?thisItem;
                        };
                    };
                    
                    return null;

                };
                case(_){

                    assert(false);
                    //unreachable
                    return null;
                }

            };

        };

        ////////////////////////////////////
        //
        // The following functions were copied from departurelabs' property.mo.  They work as a plug and play
        // here with CandyValue and CandyValueUnstable.
        //
        // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
        //
        // The following lines are issued under the MIT License Copyright (c) 2021 Departure Labs:
        //
        ///////////////////////////////////

        private func toPropertyMap(ps : Properties) : HashMap.HashMap<Text,Property> {
            
            let m = HashMap.HashMap<Text,Property>(ps.size(), Text.equal, Text.hash);
            for (property in ps.vals()) {
                m.put(property.name, property);
            };
            m;
        };

        private func fromPropertyMap(m : HashMap.HashMap<Text,Property>) : Properties {
            
            var ps : Properties = [];
            for ((_, p) in m.entries()) {
                ps := Array.append(ps, [p]);
            };
            ps;
        };

        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
        public func getProperties(properties : Properties, qs : [Query]) : Result.Result<Properties, PropertyError> {
            let m               = toPropertyMap(properties);
            var ps : Properties = [];
            for (q in qs.vals()) {
                switch (m.get(q.name)) {
                    case (null) {
                        // Query contained an unknown property.
                        //return #err(#NotFound);
                        //for now, ignore unfound properteis
                    };
                    case (? p)  {
                        switch (p.value) {
                            case (#Class(c)) {
                                if (q.next.size() == 0) {
                                    // Return every sub-attribute attribute.
                                    ps := Array.append(ps, [p]);
                                } else {
                                    let sps = switch (getProperties(c, q.next)) {
                                        case (#err(e)) { return #err(e); };
                                        case (#ok(v))  { v; };
                                    };
                                    
                                    ps := Array.append(ps, [{
                                        name      = p.name;
                                        value     = #Class(sps);
                                        immutable = p.immutable;
                                    }]);
                                };
                            };
                            case (other) {
                                // Not possible to get sub-attribute of a non-class property.
                                if (q.next.size() != 0) {
                                    return #err(#NotFound);
                                };
                                ps := Array.append(ps, [p]);
                            };
                        }
                    };
                };
            };
            #ok(ps);
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
        public func updateProperties(properties : Properties, us : [Update]) : Result.Result<Properties, PropertyError> {
            let m = toPropertyMap(properties);
            for (u in us.vals()) {
                switch (m.get(u.name)) {
                    case (null) {
                        // Update contained an unknown property, so it gets created.
                        switch (u.mode) {
                            case (#Next(sus)) {
                                let sps = switch(updateProperties([], sus)) {
                                    case (#err(e)) { return #err(e); };
                                    case (#ok(v))  { v; };
                                };
                                
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = #Class(sps);
                                    immutable = false;
                                });
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                    case (? p)  {
                        // Can not update immutable property.
                        if (p.immutable) {
                            return #err(#Immutable);
                        };
                        switch (u.mode) {
                            case (#Next(sus)) {
                                switch (p.value) {
                                    case (#Class(c)) {
                                        let sps = switch(updateProperties(c, sus)) {
                                            case (#err(e)) { return #err(e); };
                                            case (#ok(v))  { v; };
                                        };
                                        
                                        m.put(u.name, {
                                            name      = p.name;
                                            value     = #Class(sps);
                                            immutable = false;
                                        });
                                    };
                                    case (other) {
                                        // Not possible to update sub-attribute of a non-class property.
                                        return #err(#NotFound);
                                    };
                                };
                                return #err(#NotFound);
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = p.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                };
            };
            
            #ok(fromPropertyMap(m));
        };

        ////////////////////////////////////
        //
        // End code from Departure labs property.mo
        //
        ///////////////////////////////////

}