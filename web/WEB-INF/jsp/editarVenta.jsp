<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Venta</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <h4>Editar Venta</h4>
                </div>
                <div class="card-body">
                    <form method="POST">
                        <c:forEach var="dato" items="${lista}">
                            <div class="form-group">
                                <label>Fecha y Hora</label>
                                <input type="datetime-local" name="fecha" class="form-control" 
                                       value="<fmt:formatDate value='${dato.fecha}' pattern='yyyy-MM-dd'/>T<fmt:formatDate value='${dato.fecha}' pattern='HH:mm'/>" required="true">
                            </div>
                            <div class="form-group">
                                <label>Cliente</label>
                                <select name="idCliente" class="form-control">
                                    <c:forEach var="cliente" items="${clientes}">
                                        <option value="${cliente.idCliente}" 
                                                ${cliente.idCliente == dato.idCliente ? 'selected' : ''}>
                                            ${cliente.nombre} (ID: ${cliente.idCliente})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Total</label>
                                <input type="number" step="0.01" name="total" class="form-control" value="${dato.total}">
                            </div>
                        </c:forEach>
                        <input type="submit" value="Actualizar" class="btn btn-primary">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>