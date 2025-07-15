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