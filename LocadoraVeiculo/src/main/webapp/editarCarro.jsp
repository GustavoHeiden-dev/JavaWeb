<%@page import="controles.CarrosControler"%>
<%@page import="Dao.DaoCarros"%>
<%@page import="modelos.Carros"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Carro</title>
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
		<h1>Editar Carro</h1>

		<%
		String mensagem = null;
		String tipoMensagem = null;
		String carroidParam = request.getParameter("id"); 

		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String idHidden = request.getParameter("id");
			String placa = request.getParameter("placa");
			String marca = request.getParameter("marca");
			String modelo = request.getParameter("modelo");
			String ano = request.getParameter("ano");
			String cor = request.getParameter("cor");

			try {
				Carros CarroUpd = new Carros(placa, marca, modelo, ano, cor, idHidden);
				DaoCarros.update(CarroUpd);
				mensagem = "Carro atualizado com sucesso!";
				tipoMensagem = "success";
				
				carroidParam = idHidden; 
			} catch (RuntimeException e) {
				mensagem = "Erro ao atualizar carro: " + e.getMessage();
				tipoMensagem = "error";
			}
		}

		if (mensagem != null) {
		%>
		<p class="message <%=tipoMensagem%>"><%=mensagem%></p>
		<%
		}

		Carros carro = null;

		if (carroidParam != null && !carroidParam.isEmpty()) {
			try {
				int idNumerico = Integer.parseInt(carroidParam);
				carro = DaoCarros.getCarroById(idNumerico);
				if (carro == null) {
					mensagem = "Carro com ID " + carroidParam + " não encontrado.";
					tipoMensagem = "error";
				}
			} catch (NumberFormatException e) {
				mensagem = "ID do carro inválido. Por favor, forneça um ID numérico.";
				tipoMensagem = "error";
			} catch (RuntimeException e) {
				mensagem = "Erro ao carregar dados do carro: " + e.getMessage();
				tipoMensagem = "error";
			}
		} else {
			mensagem = "Nenhum ID de carro fornecido para edição.";
			tipoMensagem = "error";
		}

		if (carro != null && carro.getId() != null) {
		%>
		<form action="editarCarro.jsp" method="post">
		
			<input type="hidden" name="id" value="<%=carro.getId()%>">
			<label for="placa">Placa:</label> <input type="text" name="placa" id="placa" value="<%=carro.getPlaca()%>" required> 
			
			<label for="marca">Marca:</label>
			<input type="text" name="marca" id="marca" value="<%=carro.getMarca()%>" required> 
			
			<label for="modelo">Modelo:</label> 
			<input type="text" name="modelo" id="modelo" value="<%=carro.getModelo()%>" required>
			
			<label for="ano">Ano:</label> 
			<input type="text" name="ano" id="ano" value="<%=carro.getAno()%>" required>
			
			<label for="cor">Cor:</label> 
			<input type="text" name="cor" id="cor" value="<%=carro.getCor()%>" required>
			
			<input type="submit" value="Salvar Alterações" />
		</form>
		<%
		} else {
		%>
		<p class="message <%= (tipoMensagem != null ? tipoMensagem : "error") %>">
            <%= (mensagem != null ? mensagem : "Carro não encontrado ou ID inválido. Por favor, retorne e tente novamente.") %>
        </p>
		<%
		}
		%>
		<a href="Consulta.jsp" class="btn-voltar">Voltar para a Lista
			de Carros</a>
	</div>
</body>
</html>