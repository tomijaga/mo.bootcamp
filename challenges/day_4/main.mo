import Rand "mo:rand/LFSR";
import Nat8 "mo:base/Nat8";
import List "mo:base/List";

import Person "custom";
import Animal "animal";
import MyList "list";


actor{
    let rand = Rand.toIter(Rand.LFSR8(null));

    func getRand():Nat{
        return switch(rand.next()){
            case (?rand) Nat8.toNat(rand / 4);
            case (_) 0;
        };
    };

    let firstNames = ["Külli", "Antiman", "Markus", "Meiriona", "Annemarie"] ;
    let lastNames = ["Linos", "Isidora","Kibwe", "Aslan", " Leucippus"] ;
    let countries =["Greece", "Poland", "Mozambique", "Belgium", "Switzerland"];
    
    func randPerson():Person.Person {
        return {
            name = firstNames[getRand() % 5] # " " # lastNames[getRand() % 5];
            country = countries[getRand() % 5];
            age = getRand() % 120;
        };
    };

    // challenge 1
    // returns a random person
    public func fun(): async Person.Person{
        randPerson()
    };

    // challenge 4
    public func create_animal_then_takes_a_break(specie: Text, energy: Nat): async Animal.Animal{
        let animal = Animal.new(specie, energy);
        Animal.animal_sleep(animal)
    };

    // challenge 5
    stable var animals = List.nil<Animal.Animal>();

    public func push_animal( a: Animal.Animal): async (){     
        animals :=  List.push<Animal.Animal>(a, animals);   
    };   

    public func get_animals() : async [Animal.Animal]{       
        return List.toArray<Animal.Animal>(animals);   
    };

    //challenge 7 - 11 tests
    public query func is_null(l:List.List<Nat>): async Bool{
        MyList.is_null(l)
    };

    public query func last(l:List.List<Nat>): async ?Nat {
        MyList.last(l)
    };

    public query func size(l:List.List<Nat>):async Nat{
        MyList.size(l)
    };

    public query func get(l:List.List<Nat>, n:Nat):async ?Nat{
        MyList.get(l, n)
    };

    public query func reverse(l:List.List<Nat>):async List.List<Nat>{
        MyList.reverse(l)
    }

}