<%@page import="modelos.Cliente"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Consulta de Clientes | Concessionária AutoTop</title>
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

    h1 {
        text-align: center;
        color: #1f4037;
        margin-bottom: 25px;
        font-size: 2.5em;
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

   
    .empty-message {
        text-align: center;
        padding: 20px;
        font-size: 1.1em;
        color: #666;
    }

   
    .action-buttons {
        text-align: center;
        margin-top: 30px;
    }

   
     .btn-voltar {
        display: block;
        text-align: center;
        margin-top: 10px;
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
    <h1>Consulta de Clientes</h1>

    <%
   
        ClienteControler cliControler = new ClienteControler(); 
        List<Cliente> clientes = cliControler.getAll();
    %>

    <% if (clientes == null || clientes.isEmpty()) { %>
        <p class="empty-message">Nenhum cliente cadastrado ainda.</p>
    <% } else { %>
        <div class="table-responsive">
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
                        for(Cliente c : clientes){
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
    <% } %>

  
        <a href="./CadastroCli.html" class="btn-voltar">Cadastrar Novo Cliente</a>
        <a href="./Index.html" class="btn-voltar">Voltar para Home</a>
  

</div>

</body>
</html>
 