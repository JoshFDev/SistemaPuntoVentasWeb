<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Cliente</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #4895ef;
                --dark-color: #2b2d42;
                --light-color: #f8f9fa;
                --success-color: #4cc9f0;
                --warning-color: #f72585;
                --transition-speed: 0.3s;
            }
            
            body {
                font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
                background: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            .form-container {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 800px;
                overflow: hidden;
                margin: 0 20px;
            }
            
            .form-header {
                background: var(--primary-color);
                color: white;
                padding: 20px;
                text-align: center;
            }
            
            .form-header h4 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 600;
            }
            
            .form-body {
                padding: 30px;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--dark-color);
            }
            
            .form-control {
                display: block;
                width: 100%;
                padding: 12px 15px;
                font-size: 0.95rem;
                font-weight: 400;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #ced4da;
                border-radius: 6px;
                transition: all var(--transition-speed) ease;
                box-sizing: border-box;
            }
            
            .form-control:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.25);
                outline: none;
            }
            
            .btn-success {
                display: inline-block;
                padding: 12px 24px;
                font-size: 1rem;
                font-weight: 500;
                color: white;
                background-color: var(--success-color);
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: all var(--transition-speed) ease;
                text-align: center;
                margin-top: 20px;
            }
            
            .btn-success:hover {
                background-color: #3aa8d8;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(76, 201, 240, 0.3);
            }
            
            .btn-success:active {
                transform: translateY(0);
            }
            
            .btn-back {
                display: inline-block;
                padding: 10px 20px;
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--dark-color);
                background-color: #e9ecef;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: all var(--transition-speed) ease;
                text-align: center;
                margin-top: 15px;
                text-decoration: none;
                margin-left: 10px;
            }
            
            .btn-back:hover {
                background-color: #dee2e6;
                transform: translateY(-2px);
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            
            .form-row {
                display: flex;
                gap: 1.5rem;
                margin-bottom: 1.25rem;
            }
            
            .form-row .form-group {
                flex: 1;
                margin-bottom: 0;
            }
            
            .name-input-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 1rem;
            }
            
            .form-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 2rem;
            }
            
            @media (max-width: 768px) {
                .form-row {
                    flex-direction: column;
                    gap: 0;
                }
                
                .name-input-grid {
                    grid-template-columns: 1fr;
                }
                
                .form-actions {
                    flex-direction: column;
                }
                
                .btn-back {
                    margin-left: 0;
                    margin-top: 10px;
                }
            }
            
            @media (max-width: 576px) {
                .form-body {
                    padding: 25px;
                }
                
                .form-header {
                    padding: 15px;
                }
                
                .form-header h4 {
                    font-size: 1.3rem;
                }
                
                body {
                    padding: 15px;
                }
            }
        </style>
        <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'" />
        <noscript>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
        </noscript>
    </head>
    <body>
        <div class="form-container">
            <div class="form-header">
                <h4><i class="fas fa-user-edit"></i> Editar Cliente</h4>
            </div>
            <div class="form-body">
                <form method="POST">
                    <c:forEach var="dato" items="${lista}">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Nombre Completo</label>
                            <div class="name-input-grid">
                                <input type="text" name="nombre" class="form-control" value="${dato.nombre}" placeholder="Nombre" required>
                                <input type="text" name="apellidoPaterno" class="form-control" value="${dato.apellidoPaterno}" placeholder="Apellido Paterno" required>
                                <input type="text" name="apellidoMaterno" class="form-control" value="${dato.apellidoMaterno}" placeholder="Apellido Materno">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-calendar-alt"></i> Fecha de Nacimiento</label>
                                <input type="date" name="fechaNacimiento" class="form-control" value="${dato.fechaNacimiento}" required>
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-envelope"></i> Correo Electrónico</label>
                                <input type="email" name="correo" class="form-control" value="${dato.correo}" placeholder="cliente@ejemplo.com" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-phone"></i> Teléfono</label>
                                <input type="text" name="telefono" class="form-control" value="${dato.telefono}" placeholder="+52 55 1234 5678" required>
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-map-marker-alt"></i> Dirección</label>
                                <input type="text" name="direccion" class="form-control" value="${dato.direccion}" placeholder="Calle, Número, Colonia, CP" required>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Actualizar Cliente
                        </button>
                        
                        <a href="listaClientes.htm" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Volver al listado
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>