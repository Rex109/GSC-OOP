# Call of Duty 4 – GSC OOP Framework

A lightweight object-oriented programming (OOP) sugar layer for Call of Duty 4 GSC scripting.  
It allows class definitions, inheritance, constructors, method overriding, and simple object instantiation.

## 📦 Features

- Define and instantiate classes
- Inheritance with method overriding
- Constructor and `super()` calls
- `method()` and `super()` helpers for cleaner syntax
- Usable within CoD4's scripting environment

---

## 🧠 Core API

### new(cls, argsArray)
Creates a new instance of a class. If a constructor (ctor) is defined, it is automatically called.

### defineClass(methodsArray, parentClass)
Creates a new class with optional inheritance. Merges and overrides methods.

### method(obj, methodName, argsArray)
Calls a method on an object instance.

### super(obj, methodName, argsArray)
Calls a method from the parent class, useful inside overridden methods like constructors.

## 🚀 Example: Basic Inheritance

```c++
#include oop\oop_lib;

Soldier_ctor(this, args)
{
    this.name   = args[0];
    this.health = args[1];
}

Soldier_Damage(this, args)
{
    amount = args[0];

    this.health -= amount;
    if (this.health < 0)
        this.health = 0;
}

Soldier_Speak(this, args)
{
    iPrintLnBold("[Soldier " + this.name + "] HP=" + this.health);
}

Soldier()
{
    Soldier = [];
    Soldier["ctor"] = ::Soldier_ctor;
    Soldier["Speak"] = ::Soldier_Speak;
    Soldier["Damage"] = ::Soldier_Damage;

    return defineClass(Soldier);
}
```

Extend it with a HeavySoldier class

```c++
#include oop\oop_lib;
#include oop\classes\examples\soldier;

HeavySoldier_ctor(this, args)
{
    super(this, "ctor", args);
    this.armor = args[2];
}

HeavySoldier_Speak(this, args)
{
    iPrintLnBold("[Heavy Soldier " + this.name + "] HP=" + this.health + " | Armor=" + this.armor);
}

HeavySoldier()
{
    HeavySoldier = [];
    HeavySoldier["ctor"]  = ::HeavySoldier_ctor;
    HeavySoldier["Speak"] = ::HeavySoldier_Speak;

    return defineClass(HeavySoldier, Soldier());
}
```

## 🧪 Usage in Script (e.g. init())

```c++
#include oop\oop_lib;
#include oop\classes\examples\Soldier;
#include oop\classes\examples\HeavySoldier;

init()
{
    args = []; args[args.size] = "Alpha"; args[args.size] = 100000;
    alpha = new(Soldier(), args);

    args = []; args[args.size] = "Beta"; args[args.size] = 10;
    beta = new(Soldier(), args);

    args = []; args[args.size] = "Gamma"; args[args.size] = 100000; args[args.size] = 50;
    gamma = new(HeavySoldier(), args);

    while (1)
    {
        wait 1;

        // Damage Alpha and print health
        args = []; args[args.size] = 20;
        method(alpha, "Damage", args);
        method(alpha, "Speak");

        // Print Beta health
        method(beta, "Speak");

        // Damage Gamma and print health
        args = []; args[args.size] = 20;
        method(gamma, "Damage", args);
        method(gamma, "Speak");
    }
}
```