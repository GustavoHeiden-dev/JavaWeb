<%@page import="modelos.Locacao"%>
<%@page import="Dao.DaoLocacao"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int idLocacao = Integer.parseInt(request.getParameter("id"));
    Locacao loc = DaoLocacao.getById(idLocacao);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Locação</title>
    <style>
        form {
            width: 400px;
            margin: 50px auto;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
        }
        label, input {
            display: block;
            width: 100%;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<h1>Editar Locação</h1>

<form action="EditarLocacao.jsp" method="post">
    <input type="hidden" name="id" value="<%=loc.getId()%>">

    <label>Data de Início:</label>
    <input type="date" name="dataInicio" value="<%=loc.getDataInicio()%>" required>

    <label>Data de Fim:</label>
    <input type="date" name="dataFim" value="<%=loc.getDataFim()%>" required>

    <label>Valor da Diária:</label>
    <input type="number" step="0.01" name="valorDiaria" value="<%=loc.getValorDiaria()%>" required>

    <input type="submit" value="Atualizar">
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int id = Integer.parseInt(request.getParameter("id"));
        LocalDate dataInicio = LocalDate.parse(request.getParameter("dataInicio"));
        LocalDate dataFim = LocalDate.parse(request.getParameter("dataFim"));
        double valorDiaria = Double.parseDouble(request.getParameter("valorDiaria"));

        Locacao locUpdate = DaoLocacao.getById(id);
        locUpdate.setDataInicio(dataInicio);
        locUpdate.setDataFim(dataFim);
        locUpdate.setValorDiaria(valorDiaria);

        DaoLocacao.update(locUpdate);
        response.sendRedirect("Locacao.jsp");
    }
%>

</body>
</html>