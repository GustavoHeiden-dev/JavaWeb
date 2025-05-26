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
<title>Insert title here</title>
<style type="text/css">
th {
	padding: 15px;
	background-color: black;
	color: white;
}

td {
	padding: 15px;
}
</style>
</head>
<body>
	<%
	String nome = request.getParameter("nome");
	String email = request.getParameter("email");
	String fone = request.getParameter("fone");

	Cliente cliente = new Cliente();
	cliente.setNome(nome);
	cliente.setEmail(email);
	cliente.setFone(fone);

	ClienteControler cliControler = new ClienteControler();
	cliControler.salvar(cliente); 
	response.sendRedirect("verClientes.jsp");
	%>
</body>
</html>