module{
    public type Animal = {
        specie: Text;
        energy: Nat;
    };

    public func new(_specie: Text, _energy: Nat): Animal{
        return {
            specie = _specie;
            energy = _energy;
        };
    };

    public func animal_sleep(animal: Animal): Animal {
        let newAnimal = new(animal.specie, animal.energy + 10);
        newAnimal
    };
}