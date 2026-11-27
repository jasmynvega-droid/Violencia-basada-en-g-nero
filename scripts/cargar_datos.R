
# Carga y validación de la base de datos

library(haven)

ruta <- "datos/originales/V9_VBG_IES_5_UNL.sav"

if (!file.exists(ruta)) {
  stop("No se encuentra la base de datos. Consulte el README.")
}

base <- haven::read_sav(ruta)

# Validación de las variables requeridas

variables_requeridas <- c(
  "VBG_INACEPT_B1_5",
  "NIVEL_SEMSTRE",
  "EDAD",
  "SEXO_13",
  "TRAB_EST_9",
  "CLASE_SOCIAL_17",
  "FACULTAD_4"
)

variables_faltantes <- setdiff(
  variables_requeridas,
  names(base)
)

if (length(variables_faltantes) > 0) {
  stop(
    paste(
      "Variables no encontradas:",
      paste(variables_faltantes, collapse = ", ")
    )
  )
}

if (nrow(base) == 0) {
  stop("La base de datos no contiene registros.")
}

# Formato de cifras para la narrativa

formato_numero <- function(x) {
  format(
    x,
    big.mark = ".",
    decimal.mark = ",",
    scientific = FALSE,
    trim = TRUE
  )
}
