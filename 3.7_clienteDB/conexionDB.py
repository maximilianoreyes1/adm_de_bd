# ==========================================
# conexionDB.py
# Módulo de conexión y funciones auxiliares
# Adaptado para la BD "Empresa" (Gestión de Salas)
# ==========================================

import mysql.connector

# ---------- CONFIGURACIÓN DE CONEXIÓN ----------
# Ajusta estos valores según tu configuración local de MySQL
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "1234",       # Reemplaza con tu contraseña
    "database": "Empresa"     # Adaptado a la nueva BD
}

# ---------- FUNCIÓN DE CONEXIÓN ----------
def conectar():
    """
    Crea y devuelve una conexión a MySQL usando DB_CONFIG.
    """
    try:
        cnx = mysql.connector.connect(**DB_CONFIG)
        return cnx
    except mysql.connector.Error as e:
        print(f"Error fatal de conexión: {e}")
        return None

# ---------- FUNCIONES AUXILIARES PARA PROCEDIMIENTOS ALMACENADOS ----------

def call_proc_no_results(proc_name: str, args: list = None) -> bool:
    """
    Llama a un procedimiento almacenado que NO devuelve resultados 
    (INSERT, UPDATE, DELETE).
    Devuelve True si tiene éxito, False en caso de error.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        if cnx is None: 
            return False # No se pudo conectar
        
        cur = cnx.cursor()
        
        if args is None:
            cur.callproc(proc_name)
        else:
            cur.callproc(proc_name, args)
            
        cnx.commit()
        print(f"Operación '{proc_name}' ejecutada correctamente.")
        return True
        
    except mysql.connector.Error as e:
        print(f"Error ejecutando {proc_name}:", e)
        if cnx:
            try:
                cnx.rollback()
            except Exception:
                pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()


def call_proc_with_results(proc_name: str, args: list = None) -> list:
    """
    Llama a un procedimiento almacenado que DEVUELVE resultados (SELECT).
    Retorna una lista de tuplas (filas).
    """
    cnx = cur = None
    results = []
    try:
        cnx = conectar()
        if cnx is None: 
            return [] # No se pudo conectar
        
        cur = cnx.cursor()
        
        if args is None:
            cur.callproc(proc_name)
        else:
            cur.callproc(proc_name, args)

        # Iterar sobre todos los conjuntos de resultados devueltos
        for stored in cur.stored_results():
            rows = stored.fetchall()
            results.extend(rows)
            
        return results

    except mysql.connector.Error as e:
        print(f"Error leyendo resultados de {proc_name}:", e)
        return []
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()