<%@page import="modelos.Cliente"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Consulta Veículos</title>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f7f7;
        margin: 0;
        padding: 20px;
    }

    h1 {
        color: #333;
        text-align: center;
    }

    a {
        margin: 0 10px;
        text-decoration: none;
        color: #4CAF50;
        font-weight: bold;
    }

    .table-container {
        display: flex;
        justify-content: center;
        margin-top: 30px;
    }

    table {
        border-collapse: collapse;
        width: 80%;
        background-color: white;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    th {
        padding: 15px;
        background-color: #4CAF50;
        color: white;
        text-align: left;
    }

    td {
        padding: 15px;
        border-bottom: 1px solid #ddd;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .btn {
        display: inline-block;
        padding: 10px 20px;
        margin-top: 20px;
        background-color: #4CAF50;
        color: white;
        border-radius: 5px;
        text-decoration: none;
    }

    .btn:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>


<div style="text-align: center;">
    <a href="Index.html">Home</a>
    <a href="Cadastro.html">Cadastro</a>
</div>
<hr />

<%
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String fone = request.getParameter("fone");
    int id;
   

    if (nome != null && email != null && fone != null) {
        Cliente cliente = new Cliente();
       	ClienteDao clientes = new ClienteDao();
        cliente.setNome(nome);
        cliente.setEmail(email);
        cliente.setFone(fone);

        ClienteDao.adicionarCliente(cliente);
        response.sendRedirect("Consulta.jsp");
        return;
    }
%>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Fone</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Cliente> clientes = ClienteDao.getClientes();
                for (Cliente c : clientes) {
            %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNome() %></td>
                <td><%= c.getEmail() %></td>
                <td><%= c.getFone() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>