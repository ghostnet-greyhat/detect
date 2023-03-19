#!/bin/bash
#detect v 0.1

# Mostrar una ventana emergente para introducir la URL del sitio web a analizar
URL=$(zenity --entry --text "Introduzca la URL del sitio web a analizar")

# Mostrar una ventana emergente de progreso
zenity --progress --text "Analizando tecnologías web..." --auto-close

# Obtener la respuesta HTTP del sitio web y guardarla en un archivo temporal
curl -s -o response.txt "$URL"

# Buscar los encabezados de respuesta para obtener información sobre las tecnologías utilizadas
encabezados=$(grep -E "Server:|X-Powered-By:|X-AspNet-Version:" response.txt)

# Buscar archivos JavaScript, CSS y otros recursos para identificar las tecnologías utilizadas
archivos=$(grep -Eo "(src|href)=\"[^\"]+.(js|css|png|jpg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)\"" response.txt | sed 's/src=\"\|href=\"//g')

# Mostrar una ventana emergente con los resultados
zenity --info --text "Encabezados de respuesta:\n$encabezados\n\nArchivos encontrados:\n$archivos"

# Borrar el archivo temporal
rm response.txt
