<%@page import="controles.CarrosControler"%>
<%@page import="Dao.DaoCarros"%>
<%@page import="modelos.Carros"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@page import="modelos.Cliente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Cliente | Concessionária AutoTop</title>
<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(to right, #1f4037, #99f2c8);
	color: #333;
	line-height: 1.6;
}

.container {
	background-color: white;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
	width: 80%;
	max-width: 500px;
	margin: 30px auto;
	text-align: center;
}

h1 {
	text-align: center;
	color: #1f4037;
	margin-bottom: 25px;
	font-size: 2.5em;
}

form label {
	display: block;
	text-align: left;
	margin-bottom: 8px;
	color: #1f4037;
	font-weight: bold;
	font-size: 1.1em;
}

form input[type="text"], form input[type="email"], form input[type="tel"]
	{
	width: calc(100% - 22px);
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #99f2c8;
	border-radius: 8px;
	font-size: 1em;
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}

form input[type="text"]:focus, form input[type="email"]:focus, form input[type="tel"]:focus
	{
	border-color: #1f4037;
	outline: none;
}

form input[type="submit"] {
	background-color: #1f4037;
	color: white;
	padding: 12px 25px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 1.1em;
	font-weight: bold;
	transition: background-color 0.3s ease;
	margin-top: 15px;
}

form input[type="submit"]:hover {
	background-color: #145a32;
}

.message {
	margin-top: 15px;
	padding: 10px;
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
}

.success {
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.error {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.btn-voltar {
	display: inline-block;
	text-align: center;
	margin-top: 20px;
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
		<h1>Editar Cliente</h1>

		<%
		String mensagem = null;
		String tipoMensagem = null;
		String clienteIdParam = request.getParameter("id");

		if ("POST".equalsIgnoreCase(request.getMethod())) {
			clienteIdParam = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String fone = request.getParameter("fone");

			try {
				Cliente clienteUpdate = new Cliente(nome, email, fone, clienteIdParam);
				ClienteDao.update(clienteUpdate);
				mensagem = "Cliente salvo com sucesso!";
				tipoMensagem = "success";
			} catch (RuntimeException e) {
				mensagem = "Erro ao salvar cliente: " + e.getMessage();
				tipoMensagem = "error";
			}
		}

		if (mensagem != null) {
		%>
		<p class="message <%=tipoMensagem%>"><%=mensagem%></p>
		<%
		}

		Cliente cliente = null;

		if (clienteIdParam != null && !clienteIdParam.isEmpty()) {
		try {
			cliente = ClienteDao.getClienteById(Integer.parseInt(clienteIdParam));
		} catch (NumberFormatException e) {
		}
		}

		if (cliente != null && cliente.getId() != null) {
		%>
		<form action="editar.jsp" method="post">
		
			<input type="hidden" name="id" value="<%=cliente.getId()%>">
			<label for="nome">Nome:</label> <input type="text" name="nome"id="nome" value="<%=cliente.getNome()%>" required> 
			
			<label for="email">Email:</label>
			<input type="email" name="email"id="email" value="<%=cliente.getEmail()%>" required> 
			
			<label for="fone">Telefone:</label> <input type="tel" name="fone" id="fone"value="<%=cliente.getFone()%>" required>
			<input type="submit" value="Salvar Alterações" />
		</form>
		<%
		} else {
		%>
		<p class="message error">Cliente não encontrado ou ID inválido.
			Por favor, retorne e tente novamente.</p>
		<%
		}
		%>
		<a href="verClientes.jsp" class="btn-voltar">Voltar para a Lista
			de Clientes</a>
	</div>
</body>
</html>