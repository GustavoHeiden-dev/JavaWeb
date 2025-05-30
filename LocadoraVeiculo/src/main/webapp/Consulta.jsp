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
    .action-cell {
    width: 150px; 
    text-align: center;
    white-space: nowrap;
}

.action-cell .btn-action {
    display: inline-block; 
    padding:0px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9em;
    transition: background-color 0.3s ease;
    margin: 0 3px;
}



.action-cell .btn-delete {
    background-color: #f44336; 
    color: white;
}

.action-cell .btn-delete:hover {
    background-color: #da190b;
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
</style>
<script type="text/javascript">
    function confirmarExclusao(idCarro) {
        if (confirm("Tem certeza que deseja excluir o carro com ID " + idCarro + "?")) {
            document.getElementById('formDelete' + idCarro).submit();
        }
    }
</script>
</head>
<body>

<div class="container">
    <h2>Veículos Cadastrados</h2>

    <%
        String mensagem = null;
        String tipoMensagem = null;

      
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String acao = request.getParameter("acao");
            if ("deletar".equals(acao)) {
                String idParaDeletarStr = request.getParameter("id");
                    try {
                        int idParaDeletar = Integer.parseInt(idParaDeletarStr);
                        DaoCarros.delete(idParaDeletar);
                        mensagem = "Carro excluído com sucesso!";
                        tipoMensagem = "success";
                    }catch (RuntimeException e) {
                        mensagem = "Erro ao excluir carro: " + e.getMessage();
                        tipoMensagem = "error";
                        e.printStackTrace();
                    }
                 
            }
        }
        
     
        if (mensagem != null) {
        %>
            <p class="message <%=tipoMensagem%>"><%=mensagem%></p>
        <%
        }

        List<Carros> listaDeCarros = DaoCarros.getAll();
    %>

    <% if (listaDeCarros.isEmpty()) { %>
        <p style="text-align: center;">Nenhum veículo cadastrado</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                 	<th>Id</th>
                    <th>Placa</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Ano</th>
                    <th>Cor</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for (Carros carro : listaDeCarros) { %>
                <tr>
                	<td><%=carro.getId()%></td>
                    <td><%= carro.getPlaca() %></td>
                    <td><%= carro.getMarca() %></td>
                    <td><%= carro.getModelo() %></td>
                    <td><%= carro.getAno() %></td>
                    <td><%= carro.getCor() %></td>
                    <td class="action-cell">
						    <a href='editarCarro.jsp?id=<%=carro.getId()%>'><button class="btn-action btn-edit">Editar</button></a>
                            
                            <form id="formDelete<%=carro.getId()%>" action="Consulta.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="acao" value="deletar">
                                <input type="hidden" name="id" value="<%=carro.getId()%>">
                                <button type="button" class="btn-action btn-delete" onclick="confirmarExclusao(<%=carro.getId()%>)">Excluir</button>
                            </form>
						</td>
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