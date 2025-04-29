<%Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Inicio - Torneos Magic: The Gathering</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<header>
  <nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container-fluid">
      <a class="navbar-brand" href="main.jsp">Torneos MTG</a>
      <a href="login.jsp" class="btn btn-outline-light">Ingresar</a>
    </div>
  </nav>
</header>


  <!-- Contenido principal -->
  <div class="container text-center">
    <h1 class="mb-4">Gestiona tus Torneos</h1>
    <div class="row justify-content-center g-3">

      <% if (isAdmin) { %>
      <div class="col-md-4">
        <a href="torneos_web/crear.jsp" class="btn btn-success w-100 p-3">Crear Torneo</a>
      </div>
      <% } %>

      <div class="col-md-4">
        <a href="torneos_web/lista.jsp" class="btn btn-warning w-100 p-3">Lista Torneo</a>
      </div>

      <div class="col-md-4">
        <a href="torneos_web/buscar.jsp" class="btn btn-info w-100 p-3 text-white">Buscar Torneo</a>
      </div>
    </div>
  </div>

  <div class="container text-center">
    <h1 class="mb-4">Gestiona tus Jugadores</h1>
    <div class="row justify-content-center g-3">

      <% if (isAdmin) { %>
      <div class="col-md-4">
        <a href="player_web/crear.jsp" class="btn btn-success w-100 p-3">Crear Jugador</a>
      </div>
      <% } %>

      <div class="col-md-4">
        <a href="player_web/lista.jsp" class="btn btn-warning w-100 p-3">Lista Jugador</a>
      </div>

      <div class="col-md-4">
        <a href="player_web/buscar.jsp" class="btn btn-info w-100 p-3 text-white">Buscar Jugador</a>
      </div>
    </div>
  </div>

  <div class="container text-center">
    <h1 class="mb-4">Gestiona tus mazos</h1>
    <div class="row justify-content-center g-3">

      <div class="col-md-4">
        <a href="deck_web/crear.jsp" class="btn btn-success w-100 p-3">Crear Deck</a>
      </div>

      <div class="col-md-4">
        <a href="deck_web/lista.jsp" class="btn btn-warning w-100 p-3">Lista Deck</a>
      </div>

      <div class="col-md-4">
        <a href="deck_web/buscar.jsp" class="btn btn-info w-100 p-3 text-white">Buscar Deck</a>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="utiles/footer.jsp" />