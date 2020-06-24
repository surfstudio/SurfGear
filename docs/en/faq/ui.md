[Main](../main.md)

# UI FAQ

Solve problems with layout and UI.

## Text fields

- **The text box context menu (copy / cut / paste) is transparent.**
    ![build_settings](../../img/faq/context_menu_transparent.jpg)
    <br><br>
    The only way to customize the color of the context menu 
    is through the `canvasColor` field in the `ThemeData` application. 
    If the context menu has any unexpected color, 
    this is the result of overriding `canvasColor`.
    <br><br>
    It is highly discouraged to override `canvasColor` in the main theme, 
    as this may have other unexpected side effects. 
    Please note that the color of the tinted transparent area above 
    the Bottom Sheet is also defined through the `canvasColor`, 
    but there is an alternative option to 
    set it to` showModalBottomSheet (backgroundColor: Colors.transparent) `.
    <br><br>

