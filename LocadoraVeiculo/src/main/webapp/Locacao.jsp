
<%@page import="Dao.DaoCarros"%>
<%@page import="modelos.Carros"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="modelos.Cliente"%>
<%@page import="modelos.Locacao"%>
<%@page import="Dao.DaoLocacao"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gerenciar Locações</title>
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
	width: 90%;
	max-width: 1000px;
	margin: 30px auto;
	text-align: center;
}

h1, h2 {
	text-align: center;
	color: #1f4037;
	margin-bottom: 25px;
}

h1 {
	font-size: 2.5em;
}

h2 {
	font-size: 2em;
	margin-top: 40px;
}

form {
	text-align: left;
	margin-bottom: 30px;
	border: 1px solid #ddd;
	padding: 20px;
	border-radius: 10px;
	background-color: #f9f9f9;
}

form label {
	display: block;
	margin-bottom: 8px;
	color: #1f4037;
	font-weight: bold;
	font-size: 1.1em;
}

form input[type="text"], form input[type="date"], form input[type="number"],
	form select {
	width: calc(100% - 22px);
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #99f2c8;
	border-radius: 8px;
	font-size: 1em;
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
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

.action-cell form {
	display: inline-block; 
	margin: 0; 
	padding: 0;
	border: none;
	background: none; 
}

.btn-action {
	display: inline-block;
	padding: 8px 16px;
	font-size: 1em;
	font-weight: bold;
	border: none; 
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
	transition: background-color 0.3s ease;
}

.btn-delete {
	background-color: #f44336;
	color: white;
}

.btn-delete:hover {
	background-color: #da190b;
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
<script>
    function confirmarExclusaoLocacao(idLocacao) {
        if (confirm("Tem certeza que deseja excluir esta locação?")) {
            document.getElementById('formDeleteLocacao_' + idLocacao).submit();
        }
    }
</script>
</head>
<body>
	<div class="container">
		<h1>Gerenciar Locações de Veículos</h1>

		<%
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String acao = request.getParameter("acao");

			if ("registrar".equals(acao)) {
				try {
			int idCliente = Integer.parseInt(request.getParameter("idCliente"));
			int idCarro = Integer.parseInt(request.getParameter("idCarro"));
			LocalDate dataInicio = LocalDate.parse(request.getParameter("dataInicio"));
			LocalDate dataFim = LocalDate.parse(request.getParameter("dataFim"));
			double valorDiaria = Double.parseDouble(request.getParameter("valorDiaria"));

			Cliente clienteSelecionado = ClienteDao.getClienteById(idCliente);
			Carros carroSelecionado = DaoCarros.getCarroById(idCarro);

			if (clienteSelecionado != null && carroSelecionado != null) {
				Locacao novaLocacao = new Locacao(idCliente, clienteSelecionado.getNome(), idCarro,
						carroSelecionado.getPlaca(), dataInicio, dataFim, valorDiaria);
				DaoLocacao.insert(novaLocacao);
			}
			response.sendRedirect("Locacao.jsp");
			return;
				} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Locacao.jsp");
			return;
				}
			} else if ("deletarLocacao".equals(acao)) {
				String idLocacaoStr = request.getParameter("id");
				try {
			int idLocacao = Integer.parseInt(idLocacaoStr);
			DaoLocacao.delete(idLocacao);
			response.sendRedirect("Locacao.jsp");
			return;
				} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Locacao.jsp");
			return;
				}
			}
		}
		%>

		<h2>Registrar Nova Locação</h2>
		<form action="Locacao.jsp" method="post">
			<input type="hidden" name="acao" value="registrar"> <label
				for="idCliente">Cliente:</label> <select id="idCliente"
				name="idCliente" required>
				<option value="">Selecione um Cliente</option>
				<%
				List<Cliente> clientesDisponiveis = ClienteDao.getAll();
				for (Cliente cli : clientesDisponiveis) {
				%>
				<option value="<%=cli.getId()%>"><%=cli.getNome()%> (ID:
					<%=cli.getId()%>)
				</option>
				<%
				}
				%>
			</select> <label for="idCarro">Carro:</label> <select id="idCarro"
				name="idCarro" required>
				<option value="">Selecione um Carro</option>
				<%
				List<Carros> carrosDisponiveis = DaoCarros.getAll();
				for (Carros car : carrosDisponiveis) {
				%>
				<option value="<%=car.getId()%>">
					<%=car.getMarca()%>
					<%=car.getModelo()%> (<%=car.getPlaca()%>)
				</option>
				<%
				}
				%>
			</select> <label for="dataInicio">Data de Início:</label> <input type="date"
				id="dataInicio" name="dataInicio" required> <label
				for="dataFim">Data de Fim (Previsão):</label> <input type="date"
				id="dataFim" name="dataFim" required> <label
				for="valorDiaria">Valor da Diária:</label> <input type="number"
				id="valorDiaria" name="valorDiaria" step="0.01" min="0" required>

			<input type="submit" value="Registrar Locação">
		</form>

		<h2>Locações Ativas</h2>
		<%
		List<Locacao> listaDeLocacoes = DaoLocacao.getAll();
		if (listaDeLocacoes.isEmpty()) {
		%>
		<p style="text-align: center;">Nenhuma locação registrada.</p>
		<%
		} else {
		%>
		<table>
			<thead>
				<tr>
					<th>ID Locação</th>
					<th>Cliente (ID)</th>
					<th>Carro (Placa)</th>
					<th>Início</th>
					<th>Fim</th>
					<th>Valor Diária</th>
					<th>Valor Total</th>
					<th>Ações</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Locacao loc : listaDeLocacoes) {
				%>
				<tr>
					<td><%=loc.getId()%></td>
					<td><%=loc.getNomeCliente()%> (ID: <%=loc.getIdCliente()%>)</td>
					<td><%=loc.getPlacaCarro()%> (ID: <%=loc.getIdCarro()%>)</td>
					<td><%=loc.getDataInicio()%></td>
					<td><%=loc.getDataFim()%></td>
					<td>R$ <%=String.format("%.2f", loc.getValorDiaria())%></td>
					<td>R$ <%=String.format("%.2f", loc.getValorTotal())%></td>
					<td class="action-cell">
						<form id="formDeleteLocacao_<%=loc.getId()%>" action="Locacao.jsp"
							method="post">
							<input type="hidden" name="acao" value="deletarLocacao">
							<input type="hidden" name="id" value="<%=loc.getId()%>">
							<button type="button" class="btn-action btn-delete"
								onclick="confirmarExclusaoLocacao(<%=loc.getId()%>)">Excluir</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>

		<a href="Index.html" class="btn-voltar" >Voltar para Home</a>
	</div>
</body>
</html>