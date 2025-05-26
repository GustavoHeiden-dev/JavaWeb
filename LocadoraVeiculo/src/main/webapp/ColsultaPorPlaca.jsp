Java

<%@page import="controles.CarrosControler"%>
<%@page import="Dao.DaoCarros"%>
<%@page import="modelos.Carros"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Consultar Veículo | Concessionária AutoTop</title>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #1f4037, #99f2c8);
        color: #333;
        line-height: 1.6;
    }

    .navbar {
        background-color: #1f4037;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 18px 20px;
        text-decoration: none;
        font-size: 17px;
        transition: background-color 0.3s ease;
    }

    .navbar a:hover {
        background-color: #145a32;
        color: white;
    }

    .navbar a.active {
        background-color: #99f2c8;
        color: #1f4037;
    }

    .container {
        background-color: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        width: 80%;
        max-width: 900px;
        margin: 30px auto;
    }

    h2 {
        text-align: center;
        color: #1f4037;
        margin-bottom: 25px;
        font-size: 2.5em;
    }

    .search-form {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-bottom: 30px;
        padding: 15px;
        background-color: #f8f8f8;
        border-radius: 8px;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
    }

    .search-form input[type="text"] {
        flex-grow: 1;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 1em;
        max-width: 300px;
    }

    .search-form button {
        padding: 10px 20px;
        background-color: #1f4037;
        color: white;
        border: none;
        border-radius: 5px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .search-form button:hover {
        background-color: #145a32;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 12px 15px;
        text-align: left;
    }

    th {
        background-color: #1f4037;
        color: white;
        font-weight: bold;
        text-transform: uppercase;
        font-size: 0.9em;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #e0f7eb;
    }

    .message {
        text-align: center;
        padding: 20px;
        font-size: 1.1em;
        color: #666;
    }

    .action-buttons {
        text-align: center;
        margin-top: 30px;
    }

    .action-buttons a {
        display: inline-block;
        padding: 10px 20px;
        background-color: #1f4037;
        color: white;
        border: none;
        border-radius: 5px;
        font-weight: bold;
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
        margin: 0 10px;
    }

    .action-buttons a:hover {
        background-color: #145a32;
        transform: translateY(-2px);
    }
</style>
</head>
<body>

<div class="navbar">
    <a href="Index.html">Home</a>
    <a href="Cadastro.html">Cadastrar Veículo</a>
    <a href="ConsultaVeiculo.jsp" class="active">Consultar Veículos</a>
    <a href="CadastroCli.html">Cadastrar Cliente</a>
    <a href="Consulta.jsp">Consultar Clientes</a>
</div>

<div class="container">
    <h2>Consultar Veículo por Placa</h2>

    <form action="ConsultaVeiculo.jsp" method="GET" class="search-form">
        <input type="text" name="placaProcurada" id="placaProcurada" placeholder="Digite a placa do veículo" required>
        <button type="submit">Buscar</button>
    </form>

    <%
        String placaProcurada = request.getParameter("placaProcurada");
        Carros carroEncontrado = null;

        if (placaProcurada != null && !placaProcurada.trim().isEmpty()) {
            List<Carros> todosOsCarros = DaoCarros.getAll();
            for (Carros carro : todosOsCarros) {
                if (carro.getPlaca() != null && carro.getPlaca().equalsIgnoreCase(placaProcurada.trim())) {
                    carroEncontrado = carro;
                    break;
                }
            }
        }
    %>

    <% if (placaProcurada == null || placaProcurada.trim().isEmpty()) { %>
        <p class="message">Por favor, digite uma placa para buscar.</p>
    <% } else if (carroEncontrado != null) { %>
        <h3>Resultado da Busca:</h3>
        <table>
            <thead>
                <tr>
                    <th>Placa</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Ano</th>
                    <th>Cor</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= carroEncontrado.getPlaca() %></td>
                    <td><%= carroEncontrado.getMarca() %></td>
                    <td><%= carroEncontrado.getModelo() %></td>
                    <td><%= carroEncontrado.getAno() %></td>
                    <td><%= carroEncontrado.getCor() %></td>
                </tr>
            </tbody>
        </table>
    <% } else { %>
        <p class="message">Nenhum veículo encontrado com a placa: <strong><%= placaProcurada %></strong>.</p>
    <% } %>

    <div class="action-buttons">
        <a href="./Cadastro.html">Cadastrar Novo Veículo</a>
        <a href="./Index.html">Voltar para Home</a>
    </div>

</div>

</body>
</html>