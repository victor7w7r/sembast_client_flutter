String dict(int index, bool isEng, [List<String>? custom]) {

  final dictEsp = [
    "Modo Oscuro: ",
    "Inglés",
    "Español",
    "Inicio",
    "El archivo de base de datos no se ha subido aún",
    "Arrastra el archivo de base de datos aquí\no pulsa el botón de abajo para subir",
    "Sube el archivo pulsando el botón de abajo",
    "No se permite agregar más de un archivo",
    "El archivo seleccionado no es una base de datos",
    "Este archivo no es válido para la lectura",
    "Este archivo no es de sembast.",
    "Contraseña: ",
    "Cancelar",
    "Contraseña incorrecta",
    "La base de datos ${custom != null ? custom[0] : ''} ha sido cargada",
    "Escriba el store nuevo o existente",
    "Verificar",
    "Usar",
    "El store no se ha seleccionado aún",
    "Si",
    "Cerrar la base de datos",
    "¿Desea cerrar y guardar los cambios?",
    "Estado del store",
    "El store ${custom != null ? custom[0] : ''} está vacío o no está registrado",
    "El store ${custom != null ? custom[0] : ''} tiene ${custom != null && custom.length > 1 ? custom[1] : ''} records con llaves de tipo entero",
    "El store ${custom != null ? custom[0] : ''} tiene ${custom != null && custom.length > 1 ? custom[1] : ''} records con llaves de tipo cadena",
    "Store vacío",
    "Este store está vacío, ¿qué tipo de llave quieres usar? (int/str)",
    "¡OK! Este store usa llaves de tipo entero con un total de ${custom != null ? custom[0] : ''} records",
    "¡OK! Este store usa llaves de tipo cadena con un total de ${custom != null ? custom[0] : ''} records",
    "El store '${custom != null ? custom[0] : ''}' está seleccionado y listo para operar",
    "Expulsar",
    "Se ha expulsado el store exitosamente",
    "Leer",
    "Agregar",
    "Actualizar",
    "Eliminar",
    "Llave:",
    "Consultar",
    "Obtener 25 Primeros",
    "No existe ningún record con esa llave",
    "La llave debe ser un número entero",
    "¡Listo!",
    "El store está vacío",
    "El límite de consulta es de 25 elementos",
    "Obtener desde...",
    "Consulta desde... (Para 25 llegaría hasta el 50)",
    "Nueva llave: ",
    "Usar",
    "Esta llave ya existe",
    "Escribir",
    "Pulse escribir para editar el record\ndespués OK para guardarlo",
    "El formato del JSON no es válido",
    "El formato del JSON no es válido, no se permite el uso de arrays",
    "Objeto insertado exitosamente",
    "Llave existente: ",
    "Esta llave no existe",
    "Objeto actualizado exitosamente",
    "Eliminar",
    "Eliminar todo",
    "Vamos a eliminar",
    "¿Desea eliminar el record con esta llave?",
    "Objeto eliminado exitosamente",
    "Eliminemos todo",
    "¿Desea eliminar todo el store?, esta acción es irreversible",
    "Todo el store eliminado exitosamente",
    "Descargando el cliente CLI",
    "Error: No tienes conexión a internet\no no tienes permisos suficientes para descargar",
    "El proceso ha terminado con código ${custom != null ? custom[0] : ''}]",
    "Empecemos...",
    "Puedes subir el archivo de base de datos desde aquí para hacerlo de manera gráfica\n si lo haces en el tab de 'Inicio', no podrás usar el terminal",
    "Flujo de trabajo",
    "Si subiste tu archivo en 'Inicio', debes elegir el store que se te aparecerá al subir, para que todas las opciones se habiliten",
    "Cambiar de modo oscuro",
    "Cambiar de idioma",
    "Salir de Sembast Client"
  ];

  final dictEng = [
    "Dark Mode: ",
    "English",
    "Spanish",
    "Home",
    "The database file has not been uploaded yet",
    "Drag the database file here\nor press the button below to upload",
    "Upload the file by pressing the button below",
    "It is not allowed to add more than one file",
    "The selected file is not a database",
    "This file is not a database file.",
    "This file is not a sembast database file.",
    "Password: ",
    "Cancel",
    "Incorrect password",
    "The database ${custom != null ? custom[0] : ''} has been loaded",
    "Write the new or existing store",
    "Check",
    "Use",
    "The store has not been selected yet",
    "Yes",
    "Close the database",
    "Do you want to close and save the changes?",
    "Store status",
    "The store ${custom != null ? custom[0] : ''} is empty or not registered",
    "The store ${custom != null ? custom[0] : ''} has ${custom != null && custom.length > 1 ? custom[1] : ''} records with integer keys",
    "The store ${custom != null ? custom[0] : ''} has ${custom != null && custom.length > 1 ? custom[1] : ''} records with string keys",
    "Empty store",
    "This store is empty, what type of key do you want to use? (int/str)",
    "OK! This store uses integer keys with a total of ${custom != null ? custom[0] : ''} records",
    "OK! This store uses string keys with a total of ${custom != null ? custom[0] : ''} records",
    "The store '${custom != null ? custom[0] : ''}' is selected and ready to operate",
    "Detach",
    "The store has been detached successfully",
    "Read",
    "Add",
    "Update",
    "Delete",
    "Key:",
    "Query",
    "Get First 25",
    "There is no record with that key",
    "The key must be an integer number",
    "Ready!",
    "The store is empty",
    "The query limit is 25 elements",
    "Get from...",
    "Query from... (For 25 it would be until 50)",
    "New key: ",
    "Use",
    "This key already exists",
    "Write",
    "Press write to edit the record\nthen OK to save it",
    "The JSON format is not valid",
    "The JSON format is not valid, arrays are not allowed",
    "Object inserted successfully",
    "Existing key: ",
    "This key does not exist",
    "Object updated successfully",
    "Delete",
    "Delete all",
    "Delete...",
    "Do you want to delete the record with this key?",
    "Object deleted successfully",
    "Eliminate all",
    "Do you want to delete the entire store?, this action is irreversible",
    "The entire store was deleted successfully",
    "Downloading the CLI client",
    "Error: You do not have internet connection or\nyou do not have enough permissions to download",
    "The process has ended with code ${custom != null ? custom[0] : ''}",
    "Let's start...",
    "You can upload the database file from here to do it graphically\n if you do it in 'Home' tab, you will not be able to use the terminal",
    "Workflow",
    "If you uploaded your file in 'Home', you must choose the store that will appear to you when uploading, so that all options are enabled",
    "Change to dark mode",
    "Change language",
    "Exit Sembast Client"
  ];

  return isEng ? dictEsp[index] : dictEng[index];
}