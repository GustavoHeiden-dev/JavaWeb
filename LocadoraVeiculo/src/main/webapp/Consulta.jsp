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
<title>Veículos Cadastrados | Concessionária AutoTop</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #1f4037, #99f2c8);
        color: #333;
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }
    .container {
        background-color: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        width: 80%;
        max-width: 900px;
        margin-top: 30px;
    }
    h2 {
        text-align: center;
        color: #1f4037;
        margin-bottom: 25px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #1f4037;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .btn-voltar {
        display: block;
        text-align: center;
        margin-top: 30px;
        padding: 10px 20px;
        background-color: #1f4037;
        color: white;
        border: none;
        border-radius: 5px;
        font-weight: bold;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .btn-voltar:hover {
        background-color: #145a32;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Veículos Cadastrados</h2>

    <%
        List<Carros> listaDeCarros = DaoCarros.getAll();
    %>

    <% if (listaDeCarros.isEmpty()) { %>
        <p style="text-align: center;">Nenhum veículo cadastrado</p>
    <% } else { %>
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
                <% for (Carros carro : listaDeCarros) { %>
                <tr>
                    <td><%= carro.getPlaca() %></td>
                    <td><%= carro.getMarca() %></td>
                    <td><%= carro.getModelo() %></td>
                    <td><%= carro.getAno() %></td>
                    <td><%= carro.getCor() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <a href="./Cadastro.html" class="btn-voltar">Cadastrar Novo Veículo</a>
    <a href="./Index.html" class="btn-voltar" style="margin-top: 10px;">Voltar para Home</a>

</div>

</body>
</html>