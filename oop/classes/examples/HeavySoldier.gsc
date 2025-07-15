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
