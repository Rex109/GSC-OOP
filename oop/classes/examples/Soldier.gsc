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