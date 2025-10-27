# ==========================================
# menu.py
# Módulo de Lógica de Negocio
# Define funciones para interactuar con la BD "Empresa"
# ==========================================

from conexionDB import call_proc_no_results, call_proc_with_results
from datetime import date, datetime

# ---------- FUNCIONES PARA 'tipo_usuarios' ----------

def tipo_usuario_insertar(nombre: str, descripcion: str) -> bool:
    return call_proc_no_results("sp_insertar_tipo_usuario", [nombre, descripcion])

def tipo_usuario_borrar_logico(id_tipo: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_tipo_usuario", [id_tipo])

def tipo_usuario_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_tipo_usuarios" if activos_solo else "sp_mostrar_todos_tipo_usuarios"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Tipos de Usuario ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return
        
    print(f"{'ID':<3} | {'Nombre':<20} | {'Descripción':<40} | {'Estado':<7}")
    print("-" * 75)
    for row in rows:
        # id_tipo_usuarios, nombre_tipo_usuario, desc_tipo_usuario, ... , deleted
        estado = "Activo" if row[5] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<20} | {row[2]:<40} | {estado:<7}")

# ---------- FUNCIONES PARA 'usuarios' ----------

def usuario_insertar(nombre: str, contra: str, correo: str, fecha_nac: date, id_tipo: int) -> bool:
    args = [nombre, contra, correo, fecha_nac, id_tipo]
    return call_proc_no_results("sp_insertar_usuario", args)

def usuario_borrar_logico(id_usuario: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_usuario", [id_usuario])

def usuario_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_usuarios" if activos_solo else "sp_mostrar_todos_usuarios"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Usuarios ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return

    print(f"{'ID':<3} | {'Nombre':<25} | {'Correo':<30} | {'Fecha Nac.':<12} | {'ID Tipo':<7} | {'Estado':<7}")
    print("-" * 89)
    for row in rows:
        # id_usuarios, nombre_usuario, contraseña, correo, fecha_nac, id_tipo_usuarios, ... , deleted
        estado = "Activo" if row[8] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<25} | {row[3]:<30} | {str(row[4]):<12} | {row[5]:<7} | {estado:<7}")

# ---------- FUNCIONES PARA 'estado_dispositivo' ----------

def estado_dispositivo_insertar(nombre: str, descripcion: str) -> bool:
    return call_proc_no_results("sp_insertar_estado_dispositivo", [nombre, descripcion])

def estado_dispositivo_borrar_logico(id_estado: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_estado_dispositivo", [id_estado])

def estado_dispositivo_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_estado_dispositivo" if activos_solo else "sp_mostrar_todos_estado_dispositivo"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Estados de Dispositivo ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return
        
    print(f"{'ID':<3} | {'Nombre':<20} | {'Descripción':<40} | {'Estado':<7}")
    print("-" * 75)
    for row in rows:
        # id_estado_dispositivo, nombre_estado_equipo, desc_estado_equipo, ... , deleted
        estado = "Activo" if row[5] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<20} | {row[2]:<40} | {estado:<7}")

# ---------- FUNCIONES PARA 'tipo_dispositivo' ----------

def tipo_dispositivo_insertar(nombre: str, descripcion: str) -> bool:
    return call_proc_no_results("sp_insertar_tipo_dispositivo", [nombre, descripcion])

def tipo_dispositivo_borrar_logico(id_tipo: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_tipo_dispositivo", [id_tipo])

def tipo_dispositivo_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_tipo_dispositivo" if activos_solo else "sp_mostrar_todos_tipo_dispositivo"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Tipos de Dispositivo ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return
        
    print(f"{'ID':<3} | {'Nombre':<20} | {'Descripción':<40} | {'Estado':<7}")
    print("-" * 75)
    for row in rows:
        # id_tipo_dispositivo, nombre_tipo_dispositivo, desc_tipo_dispositivo, ... , deleted
        estado = "Activo" if row[5] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<20} | {row[2]:<40} | {estado:<7}")

# ---------- FUNCIONES PARA 'estado_salas' ----------

def estado_salas_insertar(nombre: str, descripcion: str) -> bool:
    return call_proc_no_results("sp_insertar_estado_salas", [nombre, descripcion])

def estado_salas_borrar_logico(id_estado: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_estado_salas", [id_estado])

def estado_salas_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_estado_salas" if activos_solo else "sp_mostrar_todos_estado_salas"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Estados de Sala ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return
        
    print(f"{'ID':<3} | {'Nombre':<20} | {'Descripción':<40} | {'Estado':<7}")
    print("-" * 75)
    for row in rows:
        # id_estado_salas, nombre_estado_sala, desc_estado_sala, ... , deleted
        estado = "Activo" if row[5] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<20} | {row[2]:<40} | {estado:<7}")

# ---------- FUNCIONES PARA 'salas' ----------

def sala_insertar(nombre: str, ubicacion: str, capacidad: int, id_estado: int) -> bool:
    args = [nombre, ubicacion, capacidad, id_estado]
    return call_proc_no_results("sp_insertar_salas", args)

def sala_borrar_logico(id_sala: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_salas", [id_sala])

def sala_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_salas" if activos_solo else "sp_mostrar_todos_salas"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Salas ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return

    print(f"{'ID':<3} | {'Nombre':<20} | {'Ubicación':<20} | {'Capacidad':<9} | {'ID Estado':<9} | {'Estado':<7}")
    print("-" * 75)
    for row in rows:
        # id_salas, nombre_sala, ubicacion, capacidad, id_estado_salas, ... , deleted
        estado = "Activo" if row[7] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<20} | {row[2]:<20} | {row[3]:<9} | {row[4]:<9} | {estado:<7}")

# ---------- FUNCIONES PARA 'dispositivos' ----------

def dispositivo_insertar(nombre: str, ip: str, id_sala: int, id_estado: int, id_tipo: int) -> bool:
    args = [nombre, ip, id_sala, id_estado, id_tipo]
    return call_proc_no_results("sp_insertar_dispositivo", args)

def dispositivo_borrar_logico(id_dispositivo: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_dispositivo", [id_dispositivo])

def dispositivo_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_dispositivos" if activos_solo else "sp_mostrar_todos_dispositivos"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Dispositivos ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return

    print(f"{'ID':<3} | {'Nombre':<25} | {'IP':<15} | {'ID Sala':<7} | {'ID Estado':<9} | {'ID Tipo':<7} | {'Estado':<7}")
    print("-" * 88)
    for row in rows:
        # id_dispositivos, nombre_dispositivo, IP_dispositivo, id_salas, id_estado_dispositivo, id_tipo_dispositivo, ... , deleted
        estado = "Activo" if row[8] == 0 else "Borrado"
        print(f"{row[0]:<3} | {row[1]:<25} | {row[2]:<15} | {row[3]:<7} | {row[4]:<9} | {row[5]:<7} | {estado:<7}")

# ---------- FUNCIONES PARA 'mantenimiento' ----------

def mantenimiento_insertar(fecha: datetime, desc: str, id_disp: int, id_sala: int, id_user: int) -> bool:
    args = [fecha, desc, id_disp, id_sala, id_user]
    return call_proc_no_results("sp_insertar_mantenimiento", args)

def mantenimiento_borrar_logico(id_mant: int) -> bool:
    return call_proc_no_results("sp_borrado_logico_mantenimiento", [id_mant])

def mantenimiento_listar(activos_solo: bool = True):
    proc = "sp_mostrar_activos_mantenimiento" if activos_solo else "sp_mostrar_todos_mantenimiento"
    rows = call_proc_with_results(proc)
    
    print(f"\n--- Listado de Mantenimientos ({'Activos' if activos_solo else 'Todos'}) ---")
    if not rows:
        print("No se encontraron registros.")
        return

    print(f"{'ID':<3} | {'Fecha/Hora':<20} | {'Descripción':<30} | {'ID Disp.':<8} | {'ID Sala':<7} | {'ID User':<7} | {'Estado':<7}")
    print("-" * 94)
    for row in rows:
        # id_mantenimiento, fecha_mantenimiento, desc_mantenimiento, id_dispositivos, id_salas, id_usuarios, ... , deleted
        estado = "Activo" if row[8] == 0 else "Borrado"
        # Manejar None para FKs opcionales
        id_disp_str = str(row[3]) if row[3] is not None else "N/A"
        id_sala_str = str(row[4]) if row[4] is not None else "N/A"
        
        print(f"{row[0]:<3} | {str(row[1]):<20} | {row[2]:<30} | {id_disp_str:<8} | {id_sala_str:<7} | {row[5]:<7} | {estado:<7}")