<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar sesión</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Iniciar sesión</h2>

  <%-- Mostrar mensaje de error si existe --%>
  <%
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null && !mensaje.isEmpty()) {
  %>
  <div class="alert alert-danger">
    <%= mensaje %>
  </div>
  <%
    }
  %>

  <form action="Login" method="post" class="shadow p-4 bg-white rounded">
    <div class="mb-3">
      <label for="nickname" class="form-label">Nickname</label>
      <input type="text" name="nickname" id="nickname" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">Contraseña</label>
      <input type="password" name="password" id="password" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-primary">Iniciar sesión</button>
  </form>
</div>

</body>
</html>
