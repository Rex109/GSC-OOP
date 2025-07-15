//-----------------------------------------------------------------------------
// oop_sugar.gsc
//-----------------------------------------------------------------------------

/**
 * Creates a new instance of a class.
 * Calls the constructor ("ctor") method if defined.
 * 
 * @param cls The class structure to instantiate.
 * @param argsArray Array of arguments to pass to the constructor.
 * @return obj The new instance of the class.
 */
new(cls, argsArray)
{
    obj = spawnStruct();
    obj.class   = cls;
    obj.methods = cls.methods;

    if (isDefined(obj.methods["ctor"]))
        [[ obj.methods["ctor"] ]](obj, argsArray);
    return obj;
}

/**
 * Defines a new class with optional inheritance.
 * Copies methods from the parent class if provided, then overrides/adds methods from methodsArray.
 * 
 * @param methodsArray An associative array of method names and their function references.
 * @param parentClass (Optional) Parent class structure to inherit from.
 * @return cls The newly created class structure.
 */
defineClass(methodsArray, parentClass)
{
    cls = spawnStruct();
    cls.methods = [];
    if (isDefined(parentClass))
    {
        pkeys = getArrayKeys(parentClass.methods);
        for (i = 0; i < pkeys.size; i++)
        {
            k = pkeys[i];
            cls.methods[k] = parentClass.methods[k];
        }
        cls.parent = parentClass;
    }
    mkeys = getArrayKeys(methodsArray);
    for (i = 0; i < mkeys.size; i++)
    {
        k = mkeys[i];
        cls.methods[k] = methodsArray[k];
    }
    return cls;
}

/**
 * Invokes a method on a given object.
 * 
 * @param obj The instance object.
 * @param methodName The name of the method to call.
 * @param argsArray Array of arguments to pass to the method.
 * @return The result of the method call.
 */
method(obj, methodName, argsArray)
{
    assertEx(isDefined(obj.methods[methodName]), "Method " + methodName + " not found");

    return [[ obj.methods[methodName] ]](obj, argsArray);
}

/**
 * Invokes a method from the parent class of an instance.
 * Useful for calling overridden methods such as constructors.
 * 
 * @param obj The instance object.
 * @param methodName The name of the method in the parent class to call.
 * @param argsArray Array of arguments to pass to the parent method.
 */
super(obj, methodName, argsArray)
{
    parent = obj.class.parent;
    if (isDefined(parent) && isDefined(parent.methods[methodName]))
        [[ parent.methods[methodName] ]](obj, argsArray);
}