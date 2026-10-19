<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alta de Clientes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Formulario para registro de clientes"/>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #4f46e5;
            --primary-light: #6366f1;
            --primary-dark: #4338ca;
            --secondary: #10b981;
            --accent: #f59e0b;
            --danger: #ef4444;
            --dark: #1f2937;
            --light: #f9fafb;
            --gray: #6b7280;
            --light-gray: #e5e7eb;
            --sidebar-width: 280px;
            --header-height: 70px;
            --transition: all 0.25s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            color: var(--dark);
            line-height: 1.6;
            overflow-x: hidden;
        }
        
        /* Layout Principal */
        .app-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar Moderno - Color claro */
        .app-sidebar {
            width: var(--sidebar-width);
            background: #ffffff;
            height: 100vh;
            position: fixed;
            transition: var(--transition);
            z-index: 100;
            display: flex;
            flex-direction: column;
            color: var(--dark);
            border-right: 1px solid var(--light-gray);
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
        }
        
        .sidebar-header {
            padding: 1.5rem 1.5rem 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            border-bottom: 1px solid var(--light-gray);
            min-height: 120px;
        }
        
        .sidebar-header img {
            height: 100px;
            width: auto;
            margin-bottom: 0.5rem;
            object-fit: contain;
            transition: var(--transition);
        }
        
        .sidebar-title {
            color: var(--dark);
            font-size: 1.1rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .nav-menu {
            flex: 1;
            padding: 1rem 0;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: rgba(0,0,0,0.1) transparent;
        }
        
        .nav-menu::-webkit-scrollbar {
            width: 6px;
        }
        
        .nav-menu::-webkit-scrollbar-thumb {
            background-color: rgba(0,0,0,0.1);
            border-radius: 3px;
        }
        
        .menu-section {
            margin-bottom: 1.5rem;
        }
        
        .menu-section-title {
            padding: 0.75rem 1.5rem 0.5rem;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--gray);
            font-weight: 600;
        }
        
        .menu-item {
            margin: 0.25rem 0.5rem;
            border-radius: 6px;
            overflow: hidden;
        }
        
        .menu-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.25rem;
            color: var(--gray);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
            font-size: 0.95rem;
            position: relative;
        }
        
        .menu-link:hover {
            background: rgba(79, 70, 229, 0.08);
            color: var(--primary);
        }
        
        .menu-link.active {
            background: rgba(79, 70, 229, 0.1);
            color: var(--primary);
            font-weight: 600;
        }
        
        .menu-link.active:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: var(--primary);
        }
        
        .menu-link i {
            width: 24px;
            text-align: center;
            margin-right: 12px;
            font-size: 1rem;
            transition: var(--transition);
            color: var(--gray);
        }
        
        .menu-link:hover i {
            transform: scale(1.1);
            color: var(--primary);
        }
        
        .menu-link.active i {
            color: var(--primary);
        }
        
        /* Contenido Principal */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            min-height: 100vh;
            transition: var(--transition);
        }
        
        /* Header */
        .app-header {
            height: var(--header-height);
            background: white;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            padding: 0 2rem;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 90;
        }
        
        .page-title h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }
        
        /* Form container styles */
        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            margin: 1.5rem 2rem;
            padding: 2rem;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .form-header h1 {
            font-size: 1.8rem;
            color: var(--dark);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .form-header p {
            color: var(--gray);
            font-size: 0.95rem;
        }
        
        .form-row {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1.25rem;
        }
        
        .form-group {
            margin-bottom: 1.25rem;
            flex: 1;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }
        
        .form-label.required:after {
            content: " *";
            color: var(--danger);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
            outline: none;
        }
        
        .form-control.error {
            border-color: var(--danger);
        }
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 1em;
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .error-message {
            color: var(--danger);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: block;
        }
        
        /* Button styles */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.95rem;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            gap: 0.75rem;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(79, 70, 229, 0.2);
        }
        
        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }
        
        .btn-outline:hover {
            background-color: rgba(79, 70, 229, 0.05);
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        /* Footer */
        .footer {
            text-align: center;
            padding: 1.5rem;
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        /* Name input grid */
        .name-input-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .app-sidebar {
                transform: translateX(-100%);
                z-index: 200;
            }
            
            .app-sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .mobile-menu-btn {
                display: flex;
            }
            
            .form-container {
                margin: 1rem;
                padding: 1.5rem;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .name-input-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
        }
        
        /* Botón móvil */
        .mobile-menu-btn {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            z-index: 150;
            box-shadow: 0 4px 20px rgba(79, 70, 229, 0.3);
            border: none;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .mobile-menu-btn:hover {
            background: var(--primary-dark);
            transform: scale(1.1);
        }
        
        /* Animaciones */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.4s ease-out forwards;
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar Moderno -->
        <div class="app-sidebar" id="sidebar">
            <div class="sidebar-header">
                <img src="logSPV.png" alt="Logo"/>
                <div class="sidebar-title">Gestor de Clientes</div>
            </div>
            
            <div class="nav-menu">
    <div class="menu-section">
        <div class="menu-section-title">Administración</div>
        
        <div class="menu-item">
              <a href="index.htm" class="menu-link">
                  <i class="fas fa-tachometer-alt"></i>
                 <span>Menú</span>
             </a>
                    </div>
        
        <div class="menu-item">
            <a href="AltaProducto.htm" class="menu-link">
                <i class="fas fa-plus-circle"></i>
                <span>Nuevo Producto</span>
            </a>
        </div>
        
        <div class="menu-item">
            <a href="AltaCategoria.htm" class="menu-link">
                <i class="fas fa-tags"></i>
                <span>Nueva Categoría</span>
            </a>
        </div>
        
        <div class="menu-item">
            <a href="AltaCliente.htm" class="menu-link active">
                <i class="fas fa-user-plus"></i>
                <span>Nuevo Cliente</span>
            </a>
        </div>
    </div>
    
            <div class="menu-section">
                <div class="menu-section-title">Consultas</div>

                <div class="menu-item">
                    <a href="listaProductos.htm" class="menu-link">
                        <i class="fas fa-boxes"></i>
                        <span>Productos</span>
                    </a>
                </div>

                <div class="menu-item">
                    <a href="listaCategorias.htm" class="menu-link">
                        <i class="fas fa-tag"></i>
                        <span>Categorías</span>
                    </a>
                </div>

                <div class="menu-item">
                    <a href="listaClientes.htm" class="menu-link">
                        <i class="fas fa-address-book"></i>
                        <span>Clientes</span>
                    </a>
                </div>
            </div>

            <!-- Nueva sección para Ventas -->
            <div class="menu-section">
                <div class="menu-section-title">Ventas</div>

                <div class="menu-item">
                    <a href="AltaVenta.htm" class="menu-link">
                        <i class="fas fa-cash-register"></i>
                        <span>Nueva Venta</span>
                    </a>
                </div>

                <div class="menu-item">
                    <a href="listaVentas.htm" class="menu-link">
                        <i class="fas fa-receipt"></i>
                        <span>Consulta Ventas</span>
                    </a>
                </div>
            </div>

            <!-- Nueva sección para Detalle de Ventas -->
            <div class="menu-section">
                <div class="menu-section-title">Detalle Ventas</div>

                <div class="menu-item">
                    <a href="AltaDetalleVenta.htm" class="menu-link">
                        <i class="fas fa-file-invoice"></i>
                        <span>Nuevo Detalle</span>
                    </a>
                </div>

                <div class="menu-item">
                    <a href="listaDetalleVenta.htm" class="menu-link">
                        <i class="fas fa-file-invoice-dollar"></i>
                        <span>Consulta Detalles</span>
                    </a>
                </div>
            </div>
        </div>
        </div>
        
        <!-- Contenido Principal -->
        <div class="main-content">
            <!-- Header -->
            <header class="app-header">
                <div class="page-title">
                    <h1>Registro de Clientes</h1>
                </div>
                <div>
                    <a href="index.htm" class="btn btn-primary">
                        <i class="fas fa-home"></i> Menú Principal
                    </a>
                </div>
            </header>
            
            <!-- Formulario -->
            <div class="form-container fade-in">
                <div class="form-header">
                    <h1><i class="fas fa-user-tie"></i> Nuevo Cliente</h1>
                    <p>Complete el formulario para registrar un nuevo cliente en el sistema</p>
                </div>
                
                <form method="POST" id="clienteForm" onsubmit="return validarFormulario()">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="idCliente" class="form-label required">ID Cliente:</label>
                            <input type="text" name="idCliente" class="form-control" id="idCliente" placeholder="Ej. CL-001, CUST123, etc." required>
                            <span id="idClienteError" class="error-message"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="fechaNacimiento" class="form-label required">Fecha de Nacimiento:</label>
                            <input type="date" name="fechaNacimiento" class="form-control" id="fechaNacimiento" required
                                   max="<%= java.time.LocalDate.now().minusYears(18).toString() %>" 
                                   title="El cliente debe ser mayor de 18 años">
                            <span id="fechaNacimientoError" class="error-message"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Nombre Completo:</label>
                        <div class="name-input-grid">
                            <input type="text" name="nombre" class="form-control" id="nombre" placeholder="Nombre" required
                                   pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}" title="Solo letras y espacios (2-50 caracteres)">
                            <input type="text" name="apellidoPaterno" class="form-control" id="apellidoPaterno" placeholder="Apellido Paterno" required
                                   pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}" title="Solo letras y espacios (2-50 caracteres)">
                            <input type="text" name="apellidoMaterno" class="form-control" id="apellidoMaterno" placeholder="Apellido Materno" required
                                   pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}" title="Solo letras y espacios (2-50 caracteres)">
                        </div>
                        <span id="nombreError" class="error-message"></span>
                        <span id="apellidoPaternoError" class="error-message"></span>
                        <span id="apellidoMaternoError" class="error-message"></span>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="correo" class="form-label required">Correo Electrónico:</label>
                            <input type="email" name="correo" class="form-control" id="correo" placeholder="cliente@ejemplo.com" required
                                   pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                   title="Ingrese un correo electrónico válido (ej. cliente@dominio.com)">
                            <span id="correoError" class="error-message"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="telefono" class="form-label required">Teléfono:</label>
                            <input type="tel" name="telefono" class="form-control" id="telefono" placeholder="+52 55 1234 5678" required
                                   pattern="^(\+?\d{1,3}[\s-]?)?\(?\d{2,3}\)?[\s-]?\d{3,4}[\s-]?\d{3,4}$" 
                                   title="Ingrese un número de teléfono válido (ej. +52 55 1234 5678)">
                            <span id="telefonoError" class="error-message"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="direccion" class="form-label required">Dirección Completa:</label>
                        <input type="text" name="direccion" class="form-control" id="direccion" placeholder="Calle, Número, Colonia, CP" required
                               minlength="10" maxlength="200" title="La dirección debe tener entre 10 y 200 caracteres">
                        <span id="direccionError" class="error-message"></span>
                    </div>
                        
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Registrar Cliente
                        </button>
                        
                        <a href="listaClientes.htm" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Volver al listado
                        </a>
                    </div>
                </form>
            </div>
            
            <div class="footer">
                © 2025 Sistema de Gestión de Clientes - Todos los derechos reservados
            </div>
        </div>
        
        <!-- Botón Móvil -->
        <button class="mobile-menu-btn" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>
    </div>
    
    <script>
        // Toggle Sidebar Mobile
        document.getElementById('mobileMenuBtn').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });
        
        // Active Menu Item
        document.querySelectorAll('.menu-link').forEach(link => {
            link.addEventListener('click', function() {
                // Solo actualiza las clases active si el enlace no es "#" (enlaces vacíos)
                if(this.getAttribute('href') !== '#') {
                    document.querySelectorAll('.menu-link').forEach(item => {
                        item.classList.remove('active');
                    });
                    this.classList.add('active');
                }
            });
        });
        
        // Animaciones
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.fade-in');
            elements.forEach((el, index) => {
                el.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Efecto de aparición escalonada para los inputs
            document.querySelectorAll('.form-group').forEach((group, i) => {
                group.style.opacity = '0';
                group.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    group.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    group.style.opacity = '1';
                    group.style.transform = 'translateY(0)';
                }, 150 * i);
            });
        });
        
        // Auto cerrar sidebar al cambiar de tamaño
        window.addEventListener('resize', function() {
            if (window.innerWidth > 768) {
                document.getElementById('sidebar').classList.remove('active');
            }
        });

        // Validación del formulario
        function validarFormulario() {
            let valido = true;
            
            // Validar ID Cliente (ahora acepta cualquier valor)
            const idCliente = document.getElementById('idCliente');
            const idClienteError = document.getElementById('idClienteError');
            if (idCliente.value.trim() === '') {
                idCliente.classList.add('error');
                idClienteError.textContent = 'Este campo es requerido';
                valido = false;
            } else {
                idCliente.classList.remove('error');
                idClienteError.textContent = '';
            }
            
            // Validar Fecha de Nacimiento (mayor de 18 años)
            const fechaNacimiento = document.getElementById('fechaNacimiento');
            const fechaNacimientoError = document.getElementById('fechaNacimientoError');
            if (fechaNacimiento.value) {
                const fechaNac = new Date(fechaNacimiento.value);
                const hoy = new Date();
                const edadMinima = new Date(hoy.getFullYear() - 18, hoy.getMonth(), hoy.getDate());
                
                if (fechaNac > edadMinima) {
                    fechaNacimiento.classList.add('error');
                    fechaNacimientoError.textContent = 'El cliente debe ser mayor de 18 años';
                    valido = false;
                } else {
                    fechaNacimiento.classList.remove('error');
                    fechaNacimientoError.textContent = '';
                }
            } else {
                fechaNacimiento.classList.add('error');
                fechaNacimientoError.textContent = 'Este campo es requerido';
                valido = false;
            }
            
            // Validar Nombre
            const nombre = document.getElementById('nombre');
            const nombreError = document.getElementById('nombreError');
            if (!/^[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}$/.test(nombre.value)) {
                nombre.classList.add('error');
                nombreError.textContent = 'Solo letras y espacios (2-50 caracteres)';
                valido = false;
            } else {
                nombre.classList.remove('error');
                nombreError.textContent = '';
            }
            
            // Validar Apellido Paterno
            const apellidoPaterno = document.getElementById('apellidoPaterno');
            const apellidoPaternoError = document.getElementById('apellidoPaternoError');
            if (!/^[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}$/.test(apellidoPaterno.value)) {
                apellidoPaterno.classList.add('error');
                apellidoPaternoError.textContent = 'Solo letras y espacios (2-50 caracteres)';
                valido = false;
            } else {
                apellidoPaterno.classList.remove('error');
                apellidoPaternoError.textContent = '';
            }
            
            // Validar Apellido Materno
            const apellidoMaterno = document.getElementById('apellidoMaterno');
            const apellidoMaternoError = document.getElementById('apellidoMaternoError');
            if (!/^[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}$/.test(apellidoMaterno.value)) {
                apellidoMaterno.classList.add('error');
                apellidoMaternoError.textContent = 'Solo letras y espacios (2-50 caracteres)';
                valido = false;
            } else {
                apellidoMaterno.classList.remove('error');
                apellidoMaternoError.textContent = '';
            }
            
            // Validar Correo Electrónico
            const correo = document.getElementById('correo');
            const correoError = document.getElementById('correoError');
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(correo.value)) {
                correo.classList.add('error');
                correoError.textContent = 'Ingrese un correo electrónico válido (ej. cliente@dominio.com)';
                valido = false;
            } else {
                correo.classList.remove('error');
                correoError.textContent = '';
            }
            
            // Validar Teléfono
            const telefono = document.getElementById('telefono');
            const telefonoError = document.getElementById('telefonoError');
            if (!/^(\+?\d{1,3}[\s-]?)?\(?\d{2,3}\)?[\s-]?\d{3,4}[\s-]?\d{3,4}$/.test(telefono.value)) {
                telefono.classList.add('error');
                telefonoError.textContent = 'Ingrese un número de teléfono válido (ej. +52 55 1234 5678)';
                valido = false;
            } else {
                telefono.classList.remove('error');
                telefonoError.textContent = '';
            }
            
            // Validar Dirección
            const direccion = document.getElementById('direccion');
            const direccionError = document.getElementById('direccionError');
            if (direccion.value.length < 10 || direccion.value.length > 200) {
                direccion.classList.add('error');
                direccionError.textContent = 'La dirección debe tener entre 10 y 200 caracteres';
                valido = false;
            } else {
                direccion.classList.remove('error');
                direccionError.textContent = '';
            }
            
            return valido;
        }

        // Validación en tiempo real
        document.getElementById('idCliente').addEventListener('input', function() {
            const errorElement = document.getElementById('idClienteError');
            if (this.value.trim() !== '') {
                this.classList.remove('error');
                errorElement.textContent = '';
            } else {
                this.classList.add('error');
                errorElement.textContent = 'Este campo es requerido';
            }
        });

        document.getElementById('fechaNacimiento').addEventListener('change', function() {
            const errorElement = document.getElementById('fechaNacimientoError');
            if (this.value) {
                const fechaNac = new Date(this.value);
                const hoy = new Date();
                const edadMinima = new Date(hoy.getFullYear() - 18, hoy.getMonth(), hoy.getDate());
                
                if (fechaNac > edadMinima) {
                    this.classList.add('error');
                    errorElement.textContent = 'El cliente debe ser mayor de 18 años';
                } else {
                    this.classList.remove('error');
                    errorElement.textContent = '';
                }
            } else {
                this.classList.add('error');
                errorElement.textContent = 'Este campo es requerido';
            }
        });

        // Agregar eventos de validación en tiempo real para los demás campos
        ['nombre', 'apellidoPaterno', 'apellidoMaterno'].forEach(id => {
            document.getElementById(id).addEventListener('input', function() {
                const errorElement = document.getElementById(`${id}Error`);
                if (/^[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,50}$/.test(this.value)) {
                    this.classList.remove('error');
                    errorElement.textContent = '';
                } else {
                    this.classList.add('error');
                    errorElement.textContent = 'Solo letras y espacios (2-50 caracteres)';
                }
            });
        });

        document.getElementById('correo').addEventListener('input', function() {
            const errorElement = document.getElementById('correoError');
            if (/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(this.value)) {
                this.classList.remove('error');
                errorElement.textContent = '';
            } else {
                this.classList.add('error');
                errorElement.textContent = 'Ingrese un correo electrónico válido (ej. cliente@dominio.com)';
            }
        });

        document.getElementById('telefono').addEventListener('input', function() {
            const errorElement = document.getElementById('telefonoError');
            if (/^(\+?\d{1,3}[\s-]?)?\(?\d{2,3}\)?[\s-]?\d{3,4}[\s-]?\d{3,4}$/.test(this.value)) {
                this.classList.remove('error');
                errorElement.textContent = '';
            } else {
                this.classList.add('error');
                errorElement.textContent = 'Ingrese un número de teléfono válido (ej. +52 55 1234 5678)';
            }
        });

        document.getElementById('direccion').addEventListener('input', function() {
            const errorElement = document.getElementById('direccionError');
            if (this.value.length >= 10 && this.value.length <= 200) {
                this.classList.remove('error');
                errorElement.textContent = '';
            } else {
                this.classList.add('error');
                errorElement.textContent = 'La dirección debe tener entre 10 y 200 caracteres';
            }
        });
    </script>
</body>
</html>