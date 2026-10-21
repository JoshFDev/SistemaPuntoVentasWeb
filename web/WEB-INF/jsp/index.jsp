<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestor de Ventas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Sistema de Punto de Ventas Moderno"/>
    
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
        
        /* Dashboard */
        .dashboard {
            padding: 1.5rem 2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
        }
        
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.05);
        }
        
        .stat-card.primary {
            border-top: 4px solid var(--primary);
        }
        
        .stat-card.secondary {
            border-top: 4px solid var(--secondary);
        }
        
        .stat-card.accent {
            border-top: 4px solid var(--accent);
        }
        
        .stat-title {
            font-size: 0.9rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark);
        }
        
        .stat-change {
            font-size: 0.8rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .stat-change.positive {
            color: var(--secondary);
        }
        
        .stat-change.negative {
            color: var(--danger);
        }
        
        /* Quick Actions */
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 1rem 0 1.5rem;
            position: relative;
            padding-left: 1rem;
        }
        
        .section-title:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: var(--primary);
            border-radius: 2px;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        
        .action-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
            border: 1px solid var(--light-gray);
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-light);
        }
        
        .action-card-header {
            padding: 1.5rem;
            background: #f9fafb;
            border-bottom: 1px solid var(--light-gray);
            display: flex;
            align-items: center;
        }
        
        .action-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: white;
            font-size: 1.25rem;
        }
        
        .action-icon.sales {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
        }
        
        .action-icon.products {
            background: linear-gradient(135deg, var(--secondary), #34d399);
        }
        
        .action-icon.clients {
            background: linear-gradient(135deg, var(--accent), #fbbf24);
        }
        
        .action-icon.reports {
            background: linear-gradient(135deg, #8b5cf6, #a78bfa);
        }
        .action-icon.categories {
            background: linear-gradient(135deg, #ec4899, #f472b6);
        }
        
        .action-title {
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--dark);
        }
        
        .action-description {
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        .action-card-body {
            padding: 1.5rem;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 0.75rem;
        }
        
        .action-btn {
            display: inline-flex;
            align-items: center;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            font-size: 0.9rem;
            white-space: nowrap;
        }
        
        .action-btn.primary {
            background: var(--primary);
            color: white;
        }
        
        .action-btn.primary:hover {
            background: var(--primary-dark);
        }
        
        .action-btn.secondary {
            background: white;
            color: var(--primary);
            border: 1px solid var(--primary);
        }
        
        .action-btn.secondary:hover {
            background: #f5f3ff;
        }
        
        /* Recent Activity */
        .activity-list {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            margin-top: 2rem;
        }
        
        .activity-item {
            padding: 1.25rem 1.5rem;
            display: flex;
            border-bottom: 1px solid var(--light-gray);
            transition: var(--transition);
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-item:hover {
            background: #f9fafb;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: white;
            font-size: 1rem;
            flex-shrink: 0;
        }
        
        .activity-icon.sale {
            background: var(--primary);
        }
        
        .activity-icon.product {
            background: var(--secondary);
        }
        
        .activity-icon.client {
            background: var(--accent);
        }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .activity-description {
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        .activity-time {
            color: var(--gray);
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: flex;
            align-items: center;
        }
        
        .activity-time i {
            margin-right: 0.25rem;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .actions-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }
        
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
            
            .dashboard {
                padding: 1rem;
            }
        }
        
        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
            
            .app-header {
                padding: 0 1rem;
            }
            
            .action-card-header {
                flex-direction: column;
                text-align: center;
            }
            
            .action-icon {
                margin-right: 0;
                margin-bottom: 1rem;
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
                <div class="sidebar-title">Gestor de Ventas</div>
            </div>
            
            <div class="nav-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Menú Principal</div>
                    
                    <div class="menu-item">
                        <a href="index.htm" class="menu-link active">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Menú</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="AltaVenta.htm" class="menu-link">
                            <i class="fas fa-shopping-cart"></i>
                            <span>Ventas</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="AltaProducto.htm" class="menu-link">
                            <i class="fas fa-boxes"></i>
                            <span>Productos</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="AltaCliente.htm" class="menu-link">
                            <i class="fas fa-users"></i>
                            <span>Clientes</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="AltaCategoria.htm" class="menu-link">
                            <i class="fas fa-tags"></i>
                            <span>Categorías</span>
                        </a>
                    </div>
                </div>
                
                <div class="menu-section">
                    <div class="menu-section-title">Reportes</div>
                    
                    <div class="menu-item">
                        <a href="listaVentas.htm" class="menu-link">
                            <i class="fas fa-chart-line"></i>
                            <span>Ventas</span>
                        </a>
                    </div>
                    
                    <div class="menu-item">
                        <a href="listaProductos.htm" class="menu-link">
                            <i class="fas fa-chart-pie"></i>
                            <span>Inventario</span>
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
                    <h1>Panel de Control</h1>
                </div>
            </header>
            
            <!-- Dashboard -->
            <div class="dashboard">
                <h2 class="section-title">Acciones Rápidas</h2>
                
                <div class="actions-grid">
                    <div class="action-card fade-in" style="animation-delay: 0.3s">
                        <div class="action-card-header">
                            <div class="action-icon sales">
                                <i class="fas fa-cash-register"></i>
                            </div>
                            <div>
                                <div class="action-title">Nueva Venta</div>
                                <div class="action-description">Registrar una nueva transacción</div>
                            </div>
                        </div>
                        <div class="action-card-body">
                            <a href="AltaVenta.htm" class="action-btn primary">Iniciar Venta</a>
                            <a href="listaVentas.htm" class="action-btn secondary">Ver Historial</a>
                        </div>
                    </div>

                    <div class="action-card fade-in" style="animation-delay: 0.4s">
                        <div class="action-card-header">
                            <div class="action-icon products">
                                <i class="fas fa-box-open"></i>
                            </div>
                            <div>
                                <div class="action-title">Gestión de Productos</div>
                                <div class="action-description">Administrar inventario</div>
                            </div>
                        </div>
                        <div class="action-card-body">
                            <a href="AltaProducto.htm" class="action-btn primary">Agregar Producto</a>
                            <a href="listaProductos.htm" class="action-btn secondary">Ver Inventario</a>
                        </div>
                    </div>

                    <div class="action-card fade-in" style="animation-delay: 0.5s">
                        <div class="action-card-header">
                            <div class="action-icon clients">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div>
                                <div class="action-title">Gestión de Clientes</div>
                                <div class="action-description">Administrar base de clientes</div>
                            </div>
                        </div>
                        <div class="action-card-body">
                            <a href="AltaCliente.htm" class="action-btn primary">Agregar Cliente</a>
                            <a href="listaClientes.htm" class="action-btn secondary">Ver Clientes</a>
                        </div>
                    </div>
                    
                    <div class="action-card fade-in" style="animation-delay: 0.6s">
                        <div class="action-card-header">
                            <div class="action-icon categories">
                                <i class="fas fa-tags"></i>
                            </div>
                            <div>
                                <div class="action-title">Gestión de Categorías</div>
                                <div class="action-description">Administrar categorías</div>
                            </div>
                        </div>
                        <div class="action-card-body">
                            <a href="AltaCategoria.htm" class="action-btn primary">Agregar Categoría</a>
                            <a href="listaCategorias.htm" class="action-btn secondary">Ver Categorías</a>
                        </div>
                    </div>

                    <div class="action-card fade-in" style="animation-delay: 0.6s">
                        <div class="action-card-header">
                            <div class="action-icon reports">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <div>
                                <div class="action-title">Detalles Ventas</div>
                                <div class="action-description">Generar reportes de ventas</div>
                            </div>
                        </div>
                        <div class="action-card-body">
                            <a href="AltaDetalleVenta.htm" class="action-btn primary">Generar Reporte</a>
                            <a href="listaDetalleVenta.htm" class="action-btn secondary">Ver Historial</a>
                        </div>
                    </div>
                </div>
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
        });
    </script>
</body>
</html>