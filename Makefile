# Variables de configuración
DB_NAME = LibreriaDB
DB_USER = #Tu_usuario
DB_PASS = #Tu_contrasena
BACKUP_DIR = backup
BACKUP_FILE = $(BACKUP_DIR)\Libreriabackup.sql
SQL_FILES = Estructura\tablaLibreria.sql Objeto\insertarDatosLibreria.sql Objeto\objetosLibreria.sql
DUMP_FILE = $(BACKUP_DIR)\$(DB_NAME)_dump.sql

# Regla principal para crear el backup
.PHONY: backup

backup: 
	if not exist $(BACKUP_DIR) mkdir $(BACKUP_DIR)
	mysqldump -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) > $(DUMP_FILE)
	type $(SQL_FILES) $(DUMP_FILE) > $(BACKUP_FILE)
	@echo Backup completed: $(BACKUP_FILE)

# Limpieza de archivos temporales
clean:
	del /f $(DUMP_FILE) $(BACKUP_FILE)
