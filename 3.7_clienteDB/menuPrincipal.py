# ==========================================
# menuPrincipal.py
# Menú principal para el sistema de Gestión de Salas (BD Empresa)
# ==========================================

import menu as gestor
from datetime import datetime

# ---------- FUNCIONES DE UTILIDAD (INPUT) ----------

def pedir_entero(mensaje: str) -> int:
    """ Pide un entero de forma segura. """
    while True:
        try:
            return int(input(mensaje).strip())
        except ValueError:
            print("Entrada inválida. Debe ser un número entero.")

def pedir_entero_opcional(mensaje: str) -> int | None:
    """ Pide un entero que puede ser opcional (presionar Enter). """
    entrada = input(mensaje).strip()
    if not entrada:
        return None
    while True:
        try:
            return int(entrada)
        except ValueError:
            print("Entrada inválida. Debe ser un número entero o dejarlo vacío.")
            entrada = input(mensaje).strip()
            if not entrada:
                return None

def pedir_fecha(mensaje: str) -> datetime.date:
    """ Pide una fecha (YYYY-MM-DD) de forma segura. """
    while True:
        try:
            fecha_str = input(mensaje).strip()
            return datetime.strptime(fecha_str, "%Y-%m-%d").date()
        except ValueError:
            print("Formato de fecha inválido. Debe ser YYYY-MM-DD.")

def pedir_fecha_hora(mensaje: str) -> datetime:
    """ Pide una fecha y hora (YYYY-MM-DD HH:MM) de forma segura. """
    while True:
        try:
            fecha_str = input(mensaje).strip()
            return datetime.strptime(fecha_str, "%Y-%m-%d %H:%M")
        except ValueError:
            print("Formato de fecha/hora inválido. Debe ser YYYY-MM-DD HH:MM.")

# ---------- MENÚS DE GESTIÓN (SUB-MENÚS) ----------

def menu_gestion_tipo_usuarios():
    while True:
        print("\n--- Gestión de Tipos de Usuario ---")
        print("1) Insertar nuevo tipo")
        print("2) Eliminar tipo (Borrado Lógico)")
        print("3) Listar tipos activos")
        print("4) Listar todos los tipos")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            nombre = input("Nombre del tipo (Ej: Admin): ").strip()
            desc = input("Descripción: ").strip()
            if nombre:
                gestor.tipo_usuario_insertar(nombre, desc)
            else:
                print("El nombre no puede estar vacío.")
        elif op == "2":
            id_tipo = pedir_entero("ID del tipo a eliminar: ")
            gestor.tipo_usuario_borrar_logico(id_tipo)
        elif op == "3":
            gestor.tipo_usuario_listar(activos_solo=True)
        elif op == "4":
            gestor.tipo_usuario_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_usuarios():
    while True:
        print("\n--- Gestión de Usuarios ---")
        print("1) Insertar nuevo usuario")
        print("2) Eliminar usuario (Borrado Lógico)")
        print("3) Listar usuarios activos")
        print("4) Listar todos los usuarios")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            try:
                print("--- Ingrese los datos del nuevo usuario ---")
                nombre = input("Nombre de usuario: ").strip()
                contra = input("Contraseña: ").strip()
                correo = input("Correo electrónico: ").strip()
                fecha_nac = pedir_fecha("Fecha Nacimiento (YYYY-MM-DD): ")
                
                print("Seleccione un ID de Tipo de Usuario de la lista:")
                gestor.tipo_usuario_listar(activos_solo=True)
                id_tipo = pedir_entero("ID del Tipo de Usuario: ")

                if nombre and contra and correo:
                    gestor.usuario_insertar(nombre, contra, correo, fecha_nac, id_tipo)
                else:
                    print("Nombre, contraseña y correo son obligatorios.")
            except Exception as e:
                print(f"Error al insertar: {e}")
        elif op == "2":
            id_usr = pedir_entero("ID del usuario a eliminar: ")
            gestor.usuario_borrar_logico(id_usr)
        elif op == "3":
            gestor.usuario_listar(activos_solo=True)
        elif op == "4":
            gestor.usuario_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_estado_dispositivo():
    while True:
        print("\n--- Gestión de Estados de Dispositivo ---")
        print("1) Insertar nuevo estado")
        print("2) Eliminar estado (Borrado Lógico)")
        print("3) Listar estados activos")
        print("4) Listar todos los estados")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            nombre = input("Nombre del estado (Ej: Operativo): ").strip()
            desc = input("Descripción: ").strip()
            if nombre:
                gestor.estado_dispositivo_insertar(nombre, desc)
            else:
                print("El nombre no puede estar vacío.")
        elif op == "2":
            id_est = pedir_entero("ID del estado a eliminar: ")
            gestor.estado_dispositivo_borrar_logico(id_est)
        elif op == "3":
            gestor.estado_dispositivo_listar(activos_solo=True)
        elif op == "4":
            gestor.estado_dispositivo_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_tipo_dispositivo():
    while True:
        print("\n--- Gestión de Tipos de Dispositivo ---")
        print("1) Insertar nuevo tipo")
        print("2) Eliminar tipo (Borrado Lógico)")
        print("3) Listar tipos activos")
        print("4) Listar todos los tipos")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            nombre = input("Nombre del tipo (Ej: PC, Proyector): ").strip()
            desc = input("Descripción: ").strip()
            if nombre:
                gestor.tipo_dispositivo_insertar(nombre, desc)
            else:
                print("El nombre no puede estar vacío.")
        elif op == "2":
            id_tipo = pedir_entero("ID del tipo a eliminar: ")
            gestor.tipo_dispositivo_borrar_logico(id_tipo)
        elif op == "3":
            gestor.tipo_dispositivo_listar(activos_solo=True)
        elif op == "4":
            gestor.tipo_dispositivo_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_estado_salas():
    while True:
        print("\n--- Gestión de Estados de Sala ---")
        print("1) Insertar nuevo estado")
        print("2) Eliminar estado (Borrado Lógico)")
        print("3) Listar estados activos")
        print("4) Listar todos los estados")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            nombre = input("Nombre del estado (Ej: Disponible): ").strip()
            desc = input("Descripción: ").strip()
            if nombre:
                gestor.estado_salas_insertar(nombre, desc)
            else:
                print("El nombre no puede estar vacío.")
        elif op == "2":
            id_est = pedir_entero("ID del estado a eliminar: ")
            gestor.estado_salas_borrar_logico(id_est)
        elif op == "3":
            gestor.estado_salas_listar(activos_solo=True)
        elif op == "4":
            gestor.estado_salas_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_salas():
    while True:
        print("\n--- Gestión de Salas ---")
        print("1) Insertar nueva sala")
        print("2) Eliminar sala (Borrado Lógico)")
        print("3) Listar salas activas")
        print("4) Listar todas las salas")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            try:
                print("--- Ingrese los datos de la nueva sala ---")
                nombre = input("Nombre de la sala (Ej: A-101): ").strip()
                ubicacion = input("Ubicación (Ej: Piso 1, Ala A): ").strip()
                capacidad = pedir_entero("Capacidad (ej: 30): ")
                
                print("Seleccione un ID de Estado de Sala de la lista:")
                gestor.estado_salas_listar(activos_solo=True)
                id_estado = pedir_entero("ID del Estado de la Sala: ")

                if nombre and ubicacion:
                    gestor.sala_insertar(nombre, ubicacion, capacidad, id_estado)
                else:
                    print("Nombre y ubicación son obligatorios.")
            except Exception as e:
                print(f"Error al insertar: {e}")
        elif op == "2":
            id_sala = pedir_entero("ID de la sala a eliminar: ")
            gestor.sala_borrar_logico(id_sala)
        elif op == "3":
            gestor.sala_listar(activos_solo=True)
        elif op == "4":
            gestor.sala_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_dispositivos():
    while True:
        print("\n--- Gestión de Dispositivos ---")
        print("1) Insertar nuevo dispositivo")
        print("2) Eliminar dispositivo (Borrado Lógico)")
        print("3) Listar dispositivos activos")
        print("4) Listar todos los dispositivos")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            try:
                print("--- Ingrese los datos del nuevo dispositivo ---")
                nombre = input("Nombre del dispositivo (Ej: PC-01): ").strip()
                ip = input("IP (Ej: 192.168.1.10) (Opcional): ").strip() or None
                
                print("Seleccione la Sala:")
                gestor.sala_listar(activos_solo=True)
                id_sala = pedir_entero("ID de la Sala: ")
                
                print("Seleccione el Estado del Dispositivo:")
                gestor.estado_dispositivo_listar(activos_solo=True)
                id_estado = pedir_entero("ID del Estado: ")
                
                print("Seleccione el Tipo de Dispositivo:")
                gestor.tipo_dispositivo_listar(activos_solo=True)
                id_tipo = pedir_entero("ID del Tipo: ")

                if nombre:
                    gestor.dispositivo_insertar(nombre, ip, id_sala, id_estado, id_tipo)
                else:
                    print("El nombre es obligatorio.")
            except Exception as e:
                print(f"Error al insertar: {e}")
        elif op == "2":
            id_disp = pedir_entero("ID del dispositivo a eliminar: ")
            gestor.dispositivo_borrar_logico(id_disp)
        elif op == "3":
            gestor.dispositivo_listar(activos_solo=True)
        elif op == "4":
            gestor.dispositivo_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

def menu_gestion_mantenimiento():
    while True:
        print("\n--- Gestión de Mantenimientos ---")
        print("1) Insertar nuevo mantenimiento")
        print("2) Eliminar mantenimiento (Borrado Lógico)")
        print("3) Listar mantenimientos activos")
        print("4) Listar todos los mantenimientos")
        print("0) Volver al Menú Principal")
        op = input("Selecciona una opción: ").strip()

        if op == "1":
            try:
                print("--- Ingrese los datos del nuevo mantenimiento ---")
                fecha = pedir_fecha_hora("Fecha y Hora (YYYY-MM-DD HH:MM): ")
                desc = input("Descripción del mantenimiento: ").strip()
                
                print("Asociar a un Dispositivo O Sala (deje en blanco si no aplica)")
                gestor.dispositivo_listar(activos_solo=True)
                id_disp = pedir_entero_opcional("ID del Dispositivo (Opcional): ")
                
                gestor.sala_listar(activos_solo=True)
                id_sala = pedir_entero_opcional("ID de la Sala (Opcional): ")
                
                print("Seleccione el Usuario que reporta:")
                gestor.usuario_listar(activos_solo=True)
                id_user = pedir_entero("ID del Usuario: ")

                if (id_disp is None and id_sala is None):
                    print("Debe asociar el mantenimiento al menos a una Sala o un Dispositivo.")
                elif desc:
                    gestor.mantenimiento_insertar(fecha, desc, id_disp, id_sala, id_user)
                else:
                    print("La descripción es obligatoria.")
            except Exception as e:
                print(f"Error al insertar: {e}")
        elif op == "2":
            id_mant = pedir_entero("ID del mantenimiento a eliminar: ")
            gestor.mantenimiento_borrar_logico(id_mant)
        elif op == "3":
            gestor.mantenimiento_listar(activos_solo=True)
        elif op == "4":
            gestor.mantenimiento_listar(activos_solo=False)
        elif op == "0":
            break
        else:
            print("Opción no válida.")

# ---------- MENÚ PRINCIPAL ----------

def menu_principal():
    """
    Menú principal adaptado para la BD Empresa.
    """
    while True:
        print("\n===== SISTEMA DE GESTIÓN DE SALAS Y EQUIPOS (Empresa) =====")
        print(" 1) Gestionar Tipos de Usuario")
        print(" 2) Gestionar Usuarios")
        print(" 3) Gestionar Estados de Dispositivo")
        print(" 4) Gestionar Tipos de Dispositivo")
        print(" 5) Gestionar Estados de Sala")
        print(" 6) Gestionar Salas")
        print(" 7) Gestionar Dispositivos")
        print(" 8) Gestionar Mantenimientos")
        print(" 0) Salir")
        
        opcion = input("Selecciona un módulo: ").strip()
        
        if opcion == "1":
            menu_gestion_tipo_usuarios()
        elif opcion == "2":
            menu_gestion_usuarios()
        elif opcion == "3":
            menu_gestion_estado_dispositivo()
        elif opcion == "4":
            menu_gestion_tipo_dispositivo()
        elif opcion == "5":
            menu_gestion_estado_salas()
        elif opcion == "6":
            menu_gestion_salas()
        elif opcion == "7":
            menu_gestion_dispositivos()
        elif opcion == "8":
            menu_gestion_mantenimiento()
        elif opcion == "0":
            print("Saliendo del sistema...")
            break
        else:
            print("Opción no válida. Intenta nuevamente.")

# ---------- EJECUTAR EL PROGRAMA ----------
if __name__ == "__main__":
    menu_principal()