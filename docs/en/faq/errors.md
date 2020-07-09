[Main](../main.md)

# Errors FAQ

Solve problems with errors and vorings.

## Errors

- **Many modules are underlined in red, many dependencies are unresolved.**
    <br><br>
    You need to re-synchronize the modules. To do this, 
    execute the `flutter packages get` command on each 
    of the problem modules. For faster synchronization 
    of all modules, you can use the script. From the root 
    directory of the project, run the command `./Packages_get.sh`. 
    This resynchronizes all standard modules in turn.
    <br><br>