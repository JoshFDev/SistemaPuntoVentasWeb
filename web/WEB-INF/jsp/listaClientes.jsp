<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestor de Clientes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Lista de clientes registrados"/>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Librerías para exportar -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
    
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
        
        /* Data container styles */
        .data-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            margin: 1.5rem 2rem;
            padding: 0;
            overflow: hidden;
        }
        
        .data-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .data-header h3 {
            font-size: 1.2rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--dark);
        }
        
        .data-header h3 i {
            color: var(--primary);
        }
        
        .data-header-actions {
            display: flex;
            gap: 1rem;
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
        
        .btn-success {
            background-color: var(--secondary);
            color: white;
        }
        
        .btn-success:hover {
            background-color: #0e9f6e;
        }
        
        .btn-danger {
            background-color: var(--danger);
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #dc2626;
        }
        
        .btn-warning {
            background-color: var(--accent);
            color: white;
        }
        
        .btn-warning:hover {
            background-color: #e27809;
        }
        
        /* Table styles */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
        }
        
        .data-table th {
            background-color: var(--light);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--gray);
            border-bottom: 2px solid var(--light-gray);
        }
        
        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--light-gray);
            vertical-align: middle;
        }
        
        .data-table tr:hover {
            background-color: rgba(79, 70, 229, 0.03);
        }
        
        /* Search and filter */
        .search-filter {
            display: flex;
            gap: 1.5rem;
            padding: 1.5rem;
            background: var(--light);
            border-bottom: 1px solid var(--light-gray);
        }
        
        .search-box {
            flex: 1;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 3rem;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
        }
        
        .search-box input:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
            outline: none;
        }
        
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-buttons .btn {
            padding: 0.5rem;
            min-width: 36px;
            min-height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Footer */
        .footer {
            text-align: center;
            padding: 1.5rem;
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .modal-title {
            margin: 0;
            color: var(--primary);
            font-size: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--gray);
            transition: var(--transition);
        }
        
        .modal-close:hover {
            color: var(--dark);
        }
        
        .modal-body {
            padding: 1rem 0;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding: 1rem 0 0;
            border-top: 1px solid var(--light-gray);
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
            
            .data-container {
                margin: 1rem;
            }
            
            .data-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .data-header-actions {
                width: 100%;
                justify-content: flex-end;
            }
            
            .search-filter {
                flex-direction: column;
                gap: 1rem;
            }
            
            .data-table {
                display: block;
                overflow-x: auto;
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
                        <a href="AltaCliente.htm" class="menu-link">
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
                        <a href="listaClientes.htm" class="menu-link active">
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
                    <h1>Lista de Clientes</h1>
                </div>
                <div>
                    <a href="index.htm" class="btn btn-primary">
                        <i class="fas fa-home"></i> Menú Principal
                    </a>
                </div>
            </header>
            
            <!-- Contenedor de datos -->
            <div class="data-container fade-in">
                <div class="data-header">
                    <h3><i class="fas fa-users"></i> Clientes Registrados</h3>
                    <div class="data-header-actions">
                        <button class="btn btn-outline" onclick="exportToPDF()">
                            <i class="fas fa-file-pdf"></i> PDF
                        </button>
                        <button class="btn btn-outline" onclick="exportToExcel()">
                            <i class="fas fa-file-excel"></i> Excel
                        </button>
                    </div>
                </div>
                
                <!-- Filtros y búsqueda -->
                <div class="search-filter">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Buscar clientes...">
                    </div>
                </div>
                
                <table class="data-table" id="dataTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Paterno</th>
                            <th>Materno</th>
                            <th>Fecha Nac.</th>
                            <th>Correo</th>
                            <th>Teléfono</th>
                            <th>Dirección</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dato" items="${lista}">
                            <tr>
                                <td>${dato.idCliente}</td>
                                <td>${dato.nombre}</td>
                                <td>${dato.apellidoPaterno}</td>
                                <td>${dato.apellidoMaterno}</td>
                                <td>${dato.fechaNacimiento}</td>
                                <td>${dato.correo}</td>
                                <td>${dato.telefono}</td>
                                <td>${dato.direccion}</td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="editarCliente.htm?idCliente=${dato.idCliente}" class="btn btn-warning" title="Editar">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button class="btn btn-danger" title="Eliminar" onclick="confirmDelete('${dato.idCliente}', '${dato.nombre} ${dato.apellidoPaterno}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="footer">
                © 2025 Sistema de Gestión de Clientes - Todos los derechos reservados
            </div>
        </div>
        
        <!-- Botón Móvil -->
        <button class="mobile-menu-btn" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>
        
        <!-- Modal de confirmación -->
        <div class="modal" id="confirmModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title"><i class="fas fa-exclamation-triangle"></i> Confirmar eliminación</h3>
                    <button class="modal-close" onclick="closeModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <p>¿Está seguro que desea eliminar al cliente "<span id="clientName"></span>"?</p>
                    <p>Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal()">Cancelar</button>
                    <button class="btn btn-danger" id="confirmDeleteBtn">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle Sidebar Mobile
        document.getElementById('mobileMenuBtn').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });
        
        // Configurar búsqueda
        function setupSearch() {
            const searchInput = document.getElementById('searchInput');
            const table = document.getElementById('dataTable');
            const rows = table.querySelectorAll('tbody tr');
            
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                rows.forEach(row => {
                    const nombre = row.cells[1].textContent.toLowerCase();
                    const paterno = row.cells[2].textContent.toLowerCase();
                    const materno = row.cells[3].textContent.toLowerCase();
                    const correo = row.cells[5].textContent.toLowerCase();
                    const telefono = row.cells[6].textContent.toLowerCase();
                    
                    const matchesSearch = nombre.includes(searchTerm) || 
                                        paterno.includes(searchTerm) || 
                                        materno.includes(searchTerm) || 
                                        correo.includes(searchTerm) || 
                                        telefono.includes(searchTerm);
                    
                    if (matchesSearch) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }
        
        // Función para exportar a PDF
        function exportToPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            doc.setFontSize(16);
            doc.text("Lista de Clientes", 14, 15);
            doc.setFontSize(10);
            
            const table = document.getElementById("dataTable");
            const rows = table.querySelectorAll("tr");
            
            const data = [];
            rows.forEach((row, rowIndex) => {
                const rowData = [];
                const cols = row.querySelectorAll("td, th");
                cols.forEach((col, colIndex) => {
                    if (colIndex < 8) { // Excluir la columna de acciones
                        rowData.push(col.innerText);
                    }
                });
                if (rowData.length > 0) {
                    data.push(rowData);
                }
            });
            
            doc.autoTable({
                head: [data[0]],
                body: data.slice(1),
                startY: 25,
                styles: {
                    fontSize: 8,
                    cellPadding: 2,
                    overflow: 'linebreak',
                    halign: 'left'
                },
                headStyles: {
                    fillColor: [79, 70, 229],
                    textColor: 255,
                    fontStyle: 'bold'
                },
                columnStyles: {
                    0: {cellWidth: 'auto'},
                    1: {cellWidth: 'auto'},
                    2: {cellWidth: 'auto'},
                    3: {cellWidth: 'auto'},
                    4: {cellWidth: 'auto'},
                    5: {cellWidth: 'auto'},
                    6: {cellWidth: 'auto'},
                    7: {cellWidth: 'auto'}
                },
                margin: {top: 25}
            });
            
            doc.save("clientes.pdf");
        }
        
        // Función para exportar a Excel
        function exportToExcel() {
            const table = document.getElementById("dataTable");
            const rows = table.querySelectorAll("tr");
            
            const data = [];
            rows.forEach((row, rowIndex) => {
                const rowData = [];
                const cols = row.querySelectorAll("td, th");
                cols.forEach((col, colIndex) => {
                    if (colIndex < 8) { // Excluir la columna de acciones
                        rowData.push(col.innerText);
                    }
                });
                if (rowData.length > 0) {
                    data.push(rowData);
                }
            });
            
            const wb = XLSX.utils.book_new();
            const ws = XLSX.utils.aoa_to_sheet(data);
            
            const wscols = [
                {wch: 8},   // ID
                {wch: 15},   // Nombre
                {wch: 15},   // Paterno
                {wch: 15},   // Materno
                {wch: 12},   // Fecha Nac.
                {wch: 20},   // Correo
                {wch: 15},   // Teléfono
                {wch: 25}    // Dirección
            ];
            ws['!cols'] = wscols;
            
            XLSX.utils.book_append_sheet(wb, ws, "Clientes");
            XLSX.writeFile(wb, "clientes.xlsx");
        }
        
        // Función para mostrar el modal de confirmación
        let currentClientId = '';
        
        function confirmDelete(id, name) {
            currentClientId = id;
            document.getElementById('clientName').textContent = name;
            document.getElementById('confirmModal').style.display = 'flex';
        }
        
        function closeModal() {
            document.getElementById('confirmModal').style.display = 'none';
        }
        
        // Cerrar modal al hacer clic fuera del contenido
        document.getElementById('confirmModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
        
        // Configurar el botón de confirmación de eliminación
        document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
            window.location.href = 'eliminarCliente.htm?idCliente=' + currentClientId;
        });
        
        // Inicializar búsqueda al cargar la página
        document.addEventListener('DOMContentLoaded', function() {
            setupSearch();
            
            // Resaltar el enlace activo basado en la URL actual
            const currentPage = window.location.pathname.split('/').pop();
            document.querySelectorAll('.menu-link').forEach(link => {
                if (link.getAttribute('href') === currentPage) {
                    link.classList.add('active');
                }
            });
            
            // Auto cerrar sidebar al cambiar de tamaño
            window.addEventListener('resize', function() {
                if (window.innerWidth > 768) {
                    document.getElementById('sidebar').classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>