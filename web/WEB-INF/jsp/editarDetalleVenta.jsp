<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Detalle Venta</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Formulario para editar detalles de venta"/>
    
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
        
        /* Alert styles */
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }
        
        .alert-danger {
            background-color: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            color: var(--danger);
        }
        
        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            border-left: 4px solid var(--secondary);
            color: var(--secondary);
        }
        
        .form-text {
            font-size: 0.85rem;
            color: var(--gray);
            margin-top: 0.5rem;
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
                <img src="${pageContext.request.contextPath}/logSPV.png" alt="Logo"/>
                <div class="sidebar-title">Gestor de Ventas</div>
            </div>
            
            <div class="nav-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Ventas</div>
                    
                    <div class="menu-item">
                        <a href="AltaVenta.htm" class="menu-link">
                            <i class="fas fa-cash-register"></i>
                            <span>Nueva Venta</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="AltaDetalleVenta.htm" class="menu-link">
                            <i class="fas fa-receipt"></i>
                            <span>Detalle Venta</span>
                        </a>
                    </div>
                </div>
                
                <div class="menu-section">
                    <div class="menu-section-title">Consultas</div>

                    <div class="menu-item">
                        <a href="listaVentas.htm" class="menu-link">
                            <i class="fas fa-list"></i>
                            <span>Lista Ventas</span>
                        </a>
                    </div>

                    <div class="menu-item">
                        <a href="listaDetalleVenta.htm" class="menu-link active">
                            <i class="fas fa-clipboard-list"></i>
                            <span>Detalles Ventas</span>
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
                    <h1>Editar Detalle de Venta</h1>
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
                    <h1><i class="fas fa-edit"></i> Editar Detalle de Venta</h1>
                    <p>Modifique los datos del detalle de venta según sea necesario</p>
                </div>
                
                <form method="POST" action="editarDetalleVenta.htm">
                    <input type="hidden" name="idDetalle" value="${detalle.idDetalle}">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">
                            ${success}
                        </div>
                    </c:if>
                    
                    <div class="form-row">
                        <!-- Venta (solo lectura) -->
                        <div class="form-group">
                            <label class="form-label required">Venta:</label>
                            <input type="text" class="form-control" value="Venta #${detalle.idVenta}" readonly>
                            <input type="hidden" name="idVenta" value="${detalle.idVenta}">
                        </div>
                        
                        <!-- Producto -->
                        <div class="form-group">
                            <label class="form-label required">Producto:</label>
                            <select class="form-control" name="idProducto" required id="productoSelect">
                                <c:forEach var="producto" items="${productos}">
                                    <option value="${producto.idProducto}" 
                                            data-precio="${producto.precio}" 
                                            data-stock="${producto.stock}"
                                            ${producto.idProducto == detalle.idProducto ? 'selected' : ''}>
                                        ${producto.nombreProducto} - Stock: ${producto.stock}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- Cantidad -->
                        <div class="form-group">
                            <label class="form-label required">Cantidad:</label>
                            <input type="number" class="form-control" name="cantidad" min="1" required 
                                   id="cantidad" value="${detalle.cantidad}">
                            <div class="form-text" id="stockInfo">
                                Stock disponible: ${detalle.stock}
                            </div>
                        </div>
                        
                        <!-- Precio Unitario -->
                        <div class="form-group">
                            <label class="form-label required">Precio Unitario:</label>
                            <input type="number" step="0.01" class="form-control" name="precioUnitario" 
                                   min="0.01" required id="precioUnitario" value="${detalle.precioUnitario}">
                            <div class="form-text">Precio base del producto</div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- Descuento -->
                        <div class="form-group">
                            <label class="form-label">Descuento:</label>
                            <input type="number" step="0.01" class="form-control" name="descuento" 
                                   min="0" value="${detalle.descuento}" required>
                            <div class="form-text">Descuento por unidad</div>
                        </div>
                        
                        <!-- Subtotal (calculado automáticamente) -->
                        <div class="form-group">
                            <label class="form-label">Subtotal:</label>
                            <input type="number" step="0.01" class="form-control" readonly id="subtotal"
                                   value="${(detalle.precioUnitario - detalle.descuento) * detalle.cantidad}">
                            <div class="form-text">Calculado automáticamente</div>
                            <div id="subtotalWarning" class="error-message" style="display: none;">
                                ¡El subtotal es negativo! Revise precio y descuento.
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                        <a href="listaDetalleVenta.htm" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Regresar
                        </a>
                    </div>
                </form>
            </div>
            
            <div class="footer">
                © 2025 Sistema de Gestión de Ventas - Todos los derechos reservados
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
                document.querySelectorAll('.menu-link').forEach(item => {
                    item.classList.remove('active');
                });
                this.classList.add('active');
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
            
            // Inicializar valores basados en el producto seleccionado
            const productoSelect = document.getElementById('productoSelect');
            const selectedOption = productoSelect.options[productoSelect.selectedIndex];
            if (selectedOption) {
                document.getElementById('stockInfo').textContent = 'Stock disponible: ' + selectedOption.dataset.stock;
            }
        });
        
        // Auto cerrar sidebar al cambiar de tamaño
        window.addEventListener('resize', function() {
            if (window.innerWidth > 768) {
                document.getElementById('sidebar').classList.remove('active');
            }
        });

        // Función para calcular el subtotal
        function calcularSubtotal() {
            const cantidad = parseFloat(document.getElementById('cantidad').value) || 0;
            const precio = parseFloat(document.getElementById('precioUnitario').value) || 0;
            const descuento = parseFloat(document.querySelector('[name="descuento"]').value) || 0;
            
            // Validar que el descuento no sea mayor que el precio
            if (descuento > precio) {
                document.querySelector('[name="descuento"]').classList.add('error');
                const errorMsg = document.createElement('span');
                errorMsg.className = 'error-message';
                errorMsg.textContent = 'El descuento no puede ser mayor que el precio unitario';
                document.querySelector('[name="descuento"]').parentNode.insertBefore(errorMsg, document.querySelector('[name="descuento"]').nextSibling);
                return;
            } else {
                document.querySelector('[name="descuento"]').classList.remove('error');
                const existingError = document.querySelector('[name="descuento"] ~ .error-message');
                if (existingError) {
                    existingError.remove();
                }
            }
            
            const subtotal = (precio - descuento) * cantidad;
            document.getElementById('subtotal').value = subtotal.toFixed(2);
            
            // Resaltar si es negativo (aunque ya debería estar validado)
            if (subtotal < 0) {
                document.getElementById('subtotal').classList.add('error');
            } else {
                document.getElementById('subtotal').classList.remove('error');
            }
        }
        
        // Actualizar precio al seleccionar producto
        document.getElementById('productoSelect').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            if (selectedOption.dataset.precio) {
                document.getElementById('precioUnitario').value = selectedOption.dataset.precio;
                document.getElementById('stockInfo').textContent = 'Stock disponible: ' + selectedOption.dataset.stock;
            } else {
                document.getElementById('precioUnitario').value = '';
                document.getElementById('stockInfo').textContent = 'Stock disponible: ';
            }
            calcularSubtotal();
        });
        
        // Escuchar cambios en cantidad, precio y descuento
        ['cantidad', 'precioUnitario'].forEach(id => {
            document.getElementById(id).addEventListener('input', calcularSubtotal);
        });
        document.querySelector('[name="descuento"]').addEventListener('input', calcularSubtotal);
        
        // Inicializar cálculo
        calcularSubtotal();
        
        // Validación del formulario
        document.querySelector('form').addEventListener('submit', function(e) {
            let isValid = true;
            const requiredFields = [
                {id: 'productoSelect', name: 'Producto'},
                {id: 'cantidad', name: 'Cantidad'},
                {id: 'precioUnitario', name: 'Precio Unitario'}
            ];
            
            // Validar campos requeridos
            requiredFields.forEach(field => {
                const element = document.getElementById(field.id);
                if (!element.value.trim()) {
                    element.classList.add('error');
                    isValid = false;
                    
                    // Crear mensaje de error si no existe
                    if (!element.nextElementSibling || !element.nextElementSibling.classList.contains('error-message')) {
                        const errorMsg = document.createElement('span');
                        errorMsg.className = 'error-message';
                        errorMsg.textContent = `El campo ${field.name} es requerido`;
                        element.parentNode.insertBefore(errorMsg, element.nextSibling);
                    }
                } else {
                    element.classList.remove('error');
                }
            });
            
            // Validar cantidad vs stock
            const productoSelect = document.getElementById('productoSelect');
            const selectedOption = productoSelect.options[productoSelect.selectedIndex];
            const stockDisponible = selectedOption ? parseFloat(selectedOption.dataset.stock) || 0 : 0;
            const cantidad = parseFloat(document.getElementById('cantidad').value) || 0;
            
            if (cantidad > stockDisponible) {
                document.getElementById('cantidad').classList.add('error');
                const stockError = document.createElement('span');
                stockError.className = 'error-message';
                stockError.textContent = `La cantidad no puede superar el stock disponible (${stockDisponible})`;
                document.getElementById('cantidad').parentNode.insertBefore(stockError, document.getElementById('cantidad').nextSibling);
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
                
                // Desplazarse al primer error
                const firstError = document.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
        
        // Limpiar errores al cambiar los campos
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('error');
            });
        });
    </script>
</body>
</html>